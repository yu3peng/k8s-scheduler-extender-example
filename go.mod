module k8s-scheduler-extender-example

go 1.13

// 在go modules中使用replace替换无法直接获取的package（golang.org/x/...）
replace (
	k8s.io/api => k8s.io/api v0.17.0
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.17.0
	k8s.io/apimachinery => k8s.io/apimachinery v0.17.0
	k8s.io/apiserver => k8s.io/apiserver v0.17.0
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.17.0
	k8s.io/client-go => k8s.io/client-go v0.17.0
	k8s.io/cloud-provider => k8s.io/cloud-provider v0.17.0
	k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.17.0
	k8s.io/code-generator => k8s.io/code-generator v0.17.0
	k8s.io/component-base => k8s.io/component-base v0.17.0
	k8s.io/cri-api => k8s.io/cri-api v0.17.0
	k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.17.0
	k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.17.0
	k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.17.0
	k8s.io/kube-proxy => k8s.io/kube-proxy v0.17.0
	k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.17.0
	k8s.io/kubectl => k8s.io/kubectl v0.17.0
	k8s.io/kubelet => k8s.io/kubelet v0.17.0
	k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.17.0
	k8s.io/metrics => k8s.io/metrics v0.17.0
	k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.17.0
)

// require 就是需要的所有依赖包,在每个依赖包的后面已经表明了版本号
require (
        // 取的版本为 https://github.com/comail/colog/commit/fba8e7b1f46c3607f09760ce3880066e7ff57c5a
	github.com/comail/colog v0.0.0-20160416085026-fba8e7b1f46c
        // 取的版本为 https://github.com/julienschmidt/httprouter/tree/v1.3.0
	github.com/julienschmidt/httprouter v1.3.0
	k8s.io/api v0.17.0
	k8s.io/apimachinery v0.17.0
	k8s.io/kubernetes v1.17.0
)

// [谈谈go.sum](https://studygolang.com/articles/25658)
// go.sum 的本意在于提供防篡改的保障
// Go 在做依赖管理时会创建两个文件，go.mod 和 go.sum
// go.sum 的每一行都是一个条目，大致是这样的格式：
// <module> <version>/go.mod <hash>
// 其中module是依赖的路径，version是依赖的版本号。hash是以h1:开头的字符串，表示生成checksum的算法是第一版的hash算法（sha256）
// 之所以 Go 会在依赖管理时引入 go.sum 这样的角色，是为了实现下面的目标：
//（1）提供分布式环境下的包管理依赖内容校验
//（2）作为 transparent log 来加强安全性
