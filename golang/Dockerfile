FROM centos:centos7.6.1810

MAINTAINER lihong leehongitrd@163.com

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

#ADD VMware-vix-disklib-6.0.0-2498720.x86_64.tar.gz /opt/

ADD go1.15.7.linux-amd64.tar.gz  /usr/local/

#RUN go env -w GO111MODULE=on && \
#    go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct

ARG _GOROOT=/usr/local/go
ARG _GOPATH=/root/workspace

# config GOROOT
ENV GOROOT=$_GOROOT
ENV PATH=$PATH:$_GOROOT/bin:$_GOPATH/bin

# config gopath
ENV GOPATH=$_GOPATH

RUN yum install -y git gcc gcc-g++ && \
			git config --system http.sslverify false && \
			mkdir -p /root/workspace/src/github.com/cmigrate && \
			cd /tmp/ && git clone --recursive https://github.com/DifficultWork/gopath.git && \
			cp -a /tmp/gopath/src/* /root/workspace/src  && \
      go install github.com/nsf/gocode && \
      go install github.com/uudashr/gopkgs/cmd/gopkgs && \
      go install github.com/rogpeppe/godef && \
      go install github.com/lukehoban/go-outline && \ 
      go install github.com/newhook/go-symbols && \
      go install golang.org/x/tools/cmd/guru && \ 
      go install golang.org/x/tools/cmd/gorename && \
      go install github.com/josharian/impl && \
      go install github.com/sqs/goreturns && \
      go install github.com/bytbox/golint && \
      go install github.com/cweill/gotests/gotests && \
      go install github.com/go-delve/delve/cmd/dlv && \
			yum clean all && \
      rm -rf /tmp/* 		

