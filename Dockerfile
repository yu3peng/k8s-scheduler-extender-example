# 从 Docker 17.05版本起，Docker开始支持容器镜像的多阶段构建
FROM golang:1.13-alpine as builder
# ARG 所设置的构建环境的环境变量，在将来容器运行时是不会存在这些环境变量的
ARG VERSION=0.0.1

# Enable the go modules feature
ENV GO111MODULE=on
# 在主流编程语言中，Go的移植性已经是数一数二的了
# 尤其是Go 1.5之后，Go将runtime中的C代码都用Go重写了
# 对libc的依赖已经降到最低了，但仍有一些feature提供了两个版本的实现：C实现和Go实现
# 默认情况下，即在CGO_ENABLED=1的情况下，程序和预编译的标准库都采用了C的实现
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

# build
WORKDIR /go/src/k8s-scheduler-extender-example
COPY go.mod .
COPY go.sum .
# go mod download可以下载所需要的依赖，但是依赖并不是下载到$GOPATH中，而是$GOPATH/pkg/mod中，多个项目可以共享缓存的module。
RUN GO111MODULE=on go mod download
COPY . .
# [Using ldflags to Set Version Information for Go Applications](https://www.digitalocean.com/community/tutorials/using-ldflags-to-set-version-information-for-go-applications)
# 在构建时将动态信息插入二进制文件中
# 在此标志中，ld代表链接程序，该程序将已编译源代码的不同部分链接到最终二进制文件中。 
# ldflags代表链接器标志。
# 之所以这样称呼，是因为它向基础Go工具链链接器cmd / link传递了一个标志，该标志使您可以在构建时从命令行更改导入的软件包的值
RUN go install -ldflags "-s -w -X main.version=$VERSION" k8s-scheduler-extender-example

# runtime image
FROM gcr.io/google_containers/ubuntu-slim:0.14
COPY --from=builder /go/bin/k8s-scheduler-extender-example /usr/bin/k8s-scheduler-extender-example
ENTRYPOINT ["k8s-scheduler-extender-example"]
