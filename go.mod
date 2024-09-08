module github.com/kubernetes-sigs/multi-network

go 1.23.1

require (
	github.com/containernetworking/cni v1.2.3
	k8s.io/api v0.31.0
	k8s.io/apimachinery v0.31.0
	k8s.io/client-go v0.31.0
	k8s.io/dynamic-resource-allocation v0.31.0
	k8s.io/klog/v2 v2.130.1
	k8s.io/kubelet v0.31.0
)

require (
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/emicklei/go-restful/v3 v3.11.0 // indirect
	github.com/fxamacker/cbor/v2 v2.7.0 // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/go-openapi/jsonpointer v0.21.0 // indirect
	github.com/go-openapi/jsonreference v0.20.2 // indirect
	github.com/go-openapi/swag v0.23.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/protobuf v1.5.4 // indirect
	github.com/google/gnostic-models v0.6.8 // indirect
	github.com/google/go-cmp v0.6.0 // indirect
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/mailru/easyjson v0.7.7 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/x448/float16 v0.8.4 // indirect
	golang.org/x/net v0.28.0 // indirect
	golang.org/x/oauth2 v0.21.0 // indirect
	golang.org/x/sys v0.23.0 // indirect
	golang.org/x/term v0.23.0 // indirect
	golang.org/x/text v0.17.0 // indirect
	golang.org/x/time v0.3.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240701130421-f6361c86f094 // indirect
	google.golang.org/grpc v1.65.0 // indirect
	google.golang.org/protobuf v1.34.2 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	k8s.io/kube-openapi v0.0.0-20240827152857-f7e401e7b4c2 // indirect
	k8s.io/utils v0.0.0-20240711033017-18e509b52bc8 // indirect
	sigs.k8s.io/json v0.0.0-20221116044647-bc3834ca7abd // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.4.1 // indirect
	sigs.k8s.io/yaml v1.4.0 // indirect
)

replace k8s.io/api => github.com/LionelJouin/kubernetes/staging/src/k8s.io/api v0.0.0-20240906134808-d45448c4d371

replace k8s.io/apiextensions-apiserver => github.com/LionelJouin/kubernetes/staging/src/k8s.io/apiextensions-apiserver v0.0.0-20240906134808-d45448c4d371

replace k8s.io/apimachinery => github.com/LionelJouin/kubernetes/staging/src/k8s.io/apimachinery v0.0.0-20240906134808-d45448c4d371

replace k8s.io/apiserver => github.com/LionelJouin/kubernetes/staging/src/k8s.io/apiserver v0.0.0-20240906134808-d45448c4d371

replace k8s.io/cli-runtime => github.com/LionelJouin/kubernetes/staging/src/k8s.io/cli-runtime v0.0.0-20240906134808-d45448c4d371

replace k8s.io/client-go => github.com/LionelJouin/kubernetes/staging/src/k8s.io/client-go v0.0.0-20240906134808-d45448c4d371

replace k8s.io/cloud-provider => github.com/LionelJouin/kubernetes/staging/src/k8s.io/cloud-provider v0.0.0-20240906134808-d45448c4d371

replace k8s.io/cluster-bootstrap => github.com/LionelJouin/kubernetes/staging/src/k8s.io/cluster-bootstrap v0.0.0-20240906134808-d45448c4d371

replace k8s.io/code-generator => github.com/LionelJouin/kubernetes/staging/src/k8s.io/code-generator v0.0.0-20240906134808-d45448c4d371

replace k8s.io/component-base => github.com/LionelJouin/kubernetes/staging/src/k8s.io/component-base v0.0.0-20240906134808-d45448c4d371

replace k8s.io/component-helpers => github.com/LionelJouin/kubernetes/staging/src/k8s.io/component-helpers v0.0.0-20240906134808-d45448c4d371

replace k8s.io/controller-manager => github.com/LionelJouin/kubernetes/staging/src/k8s.io/controller-manager v0.0.0-20240906134808-d45448c4d371

replace k8s.io/cri-api => github.com/LionelJouin/kubernetes/staging/src/k8s.io/cri-api v0.0.0-20240906134808-d45448c4d371

replace k8s.io/cri-client => github.com/LionelJouin/kubernetes/staging/src/k8s.io/cri-client v0.0.0-20240906134808-d45448c4d371

replace k8s.io/csi-translation-lib => github.com/LionelJouin/kubernetes/staging/src/k8s.io/csi-translation-lib v0.0.0-20240906134808-d45448c4d371

replace k8s.io/dynamic-resource-allocation => github.com/LionelJouin/kubernetes/staging/src/k8s.io/dynamic-resource-allocation v0.0.0-20240906134808-d45448c4d371

replace k8s.io/endpointslice => github.com/LionelJouin/kubernetes/staging/src/k8s.io/endpointslice v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kms => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kms v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kube-aggregator => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kube-aggregator v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kube-controller-manager => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kube-controller-manager v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kube-proxy => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kube-proxy v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kube-scheduler => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kube-scheduler v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kubectl => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kubectl v0.0.0-20240906134808-d45448c4d371

replace k8s.io/kubelet => github.com/LionelJouin/kubernetes/staging/src/k8s.io/kubelet v0.0.0-20240906134808-d45448c4d371

replace k8s.io/metrics => github.com/LionelJouin/kubernetes/staging/src/k8s.io/metrics v0.0.0-20240906134808-d45448c4d371

replace k8s.io/mount-utils => github.com/LionelJouin/kubernetes/staging/src/k8s.io/mount-utils v0.0.0-20240906134808-d45448c4d371

replace k8s.io/pod-security-admission => github.com/LionelJouin/kubernetes/staging/src/k8s.io/pod-security-admission v0.0.0-20240906134808-d45448c4d371

replace k8s.io/sample-apiserver => github.com/LionelJouin/kubernetes/staging/src/k8s.io/sample-apiserver v0.0.0-20240906134808-d45448c4d371

replace k8s.io/sample-cli-plugin => github.com/LionelJouin/kubernetes/staging/src/k8s.io/sample-cli-plugin v0.0.0-20240906134808-d45448c4d371

replace k8s.io/sample-controller => github.com/LionelJouin/kubernetes/staging/src/k8s.io/sample-controller v0.0.0-20240906134808-d45448c4d371
