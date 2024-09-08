package v1

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/containernetworking/cni/libcni"
	cnitypes "github.com/containernetworking/cni/pkg/types"
	cni100 "github.com/containernetworking/cni/pkg/types/100"
	resourcev1alpha3 "k8s.io/api/resource/v1alpha3"
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
	"k8s.io/apimachinery/pkg/types"
	"k8s.io/client-go/kubernetes"
	"k8s.io/klog/v2"
)

type PodResourceStore interface {
	Get(podUID types.UID) []*resourcev1alpha3.ResourceClaim
	Delete(podUID types.UID)
}

type CNI struct {
	podResourceStore PodResourceStore
	cniConfig        *libcni.CNIConfig
	driverName       string
	kubeClient       kubernetes.Interface
}

func New(
	driverName string,
	chrootDir string,
	cniPath []string,
	cniCacheDir string,
	kubeClient kubernetes.Interface,
	podResourceStore PodResourceStore,
) *CNI {
	exec := &chrootExec{
		Stderr:    os.Stderr,
		ChrootDir: chrootDir,
	}

	cni := &CNI{
		podResourceStore: podResourceStore,
		cniConfig:        libcni.NewCNIConfigWithCacheDir(cniPath, cniCacheDir, exec),
		driverName:       driverName,
		kubeClient:       kubeClient,
	}

	return cni
}

func (cni *CNI) AttachNetworks(
	ctx context.Context,
	podSandBoxID string,
	podUID string,
	podName string,
	podNamespace string,
	podNetworkNamespace string,
) error {
	claims := cni.podResourceStore.Get(types.UID(podUID))

	klog.Infof("cni.AttachNetworks: attach networks on pod %s (%s)", podName, podUID)

	for _, claim := range claims {
		err := cni.handleClaim(
			ctx,
			podSandBoxID,
			podUID,
			podName,
			podNamespace,
			podNetworkNamespace,
			claim,
		)
		if err != nil {
			return err
		}
	}

	return nil
}

func (cni *CNI) handleClaim(
	ctx context.Context,
	podSandBoxID string,
	podUID string,
	podName string,
	podNamespace string,
	podNetworkNamespace string,
	claim *resourcev1alpha3.ResourceClaim,
) error {
	if claim.Status.Allocation == nil ||
		len(claim.Status.Allocation.Devices.Results) != 1 ||
		len(claim.Status.Allocation.Devices.Config) != 1 ||
		claim.Status.Allocation.Devices.Results[0].Driver != cni.driverName ||
		claim.Status.Allocation.Devices.Config[0].Opaque == nil ||
		claim.Status.Allocation.Devices.Config[0].Opaque.Driver != cni.driverName {
		return nil
	}

	klog.Infof("cni.handleClaim: attach network (claim: %s) on pod %s (%s)", claim.Name, podName, podUID)

	cniParameters := &Parameters{}
	err := json.Unmarshal(claim.Status.Allocation.Devices.Config[0].Opaque.Parameters.Raw, cniParameters)
	if err != nil {
		return fmt.Errorf("cni.handleClaim: failed to json.Unmarshal Opaque.Parameters: %v", err)
	}

	result, err := cni.add(
		ctx,
		podSandBoxID,
		podUID,
		podName,
		podNamespace,
		podNetworkNamespace,
		cniParameters,
	)
	if err != nil {
		return err
	}

	resultBytes, err := json.Marshal(result)
	if err != nil {
		return fmt.Errorf("cni.handleClaim: failed to json.Marshal result (%v): %v", result, err)
	}

	cniResult, err := cni100.NewResultFromResult(result)
	if err != nil {
		return fmt.Errorf("cni.handleClaim: failed to NewResultFromResult result (%v): %v", result, err)
	}

	claim.Status.DeviceStatuses = append(claim.Status.DeviceStatuses, resourcev1alpha3.AllocatedDeviceStatus{
		Request: claim.Status.Allocation.Devices.Results[0].Request,
		Driver:  claim.Status.Allocation.Devices.Results[0].Driver,
		Pool:    claim.Status.Allocation.Devices.Results[0].Pool,
		Device:  claim.Status.Allocation.Devices.Results[0].Device,
		DeviceInfo: runtime.RawExtension{
			Raw: resultBytes,
		},
		NetworkDeviceInfo: cniResultToNetworkDeviceInfo(cniResult),
	})

	_, err = cni.kubeClient.ResourceV1alpha3().ResourceClaims(claim.GetNamespace()).UpdateStatus(ctx, claim, v1.UpdateOptions{})
	if err != nil {
		return fmt.Errorf("cni.handleClaim: failed to update resource claim status (%v): %v", result, err)
	}

	return nil
}

func (cni *CNI) add(
	ctx context.Context,
	podSandBoxID string,
	podUID string,
	podName string,
	podNamespace string,
	podNetworkNamespace string,
	parameters *Parameters,
) (cnitypes.Result, error) {
	rt := &libcni.RuntimeConf{
		ContainerID: podSandBoxID,
		NetNS:       podNetworkNamespace,
		IfName:      parameters.Interface,
		Args: [][2]string{
			{"IgnoreUnknown", "true"},
			{"K8S_POD_NAMESPACE", podNamespace},
			{"K8S_POD_NAME", podName},
			{"K8S_POD_INFRA_CONTAINER_ID", podSandBoxID},
			{"K8S_POD_UID", podUID},
		},
	}

	confList, err := libcni.ConfListFromBytes([]byte(parameters.Config))
	if err != nil {
		return nil, fmt.Errorf("cni.add: failed to ConfListFromBytes: %v", err)
	}

	result, err := cni.cniConfig.AddNetworkList(ctx, confList, rt)
	if err != nil {
		return nil, fmt.Errorf("cni.add: failed to AddNetwork: %v", err)
	}

	return result, nil
}

func (cni *CNI) DetachNetworks(
	ctx context.Context,
	podSandBoxID string,
	podUID string,
	podName string,
	podNamespace string,
	podNetworkNamespace string,
) error {
	// TODO
	return nil
}

func cniResultToNetworkDeviceInfo(cniResult *cni100.Result) resourcev1alpha3.NetworkDeviceInfo {
	networkDeviceInfo := resourcev1alpha3.NetworkDeviceInfo{}

	for _, ip := range cniResult.IPs {
		networkDeviceInfo.IPs = append(networkDeviceInfo.IPs, ip.Address.String())
	}

	for _, ifs := range cniResult.Interfaces {
		// Only pod interfaces can have sandbox information
		if ifs.Sandbox != "" {
			networkDeviceInfo.Interface = ifs.Name
			networkDeviceInfo.Mac = ifs.Mac
		}
	}

	return networkDeviceInfo
}
