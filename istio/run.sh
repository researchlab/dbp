#!/bin/bash 

export http_proxy=http://192.168.1.101:1087
export https_proxy=http://192.168.1.101:1087
export NO_PROXY=192.168.99.112

minikube start --docker-env HTTP_PROXY=$http_proxy --docker-env HTTPS_PROXY=$https_proxy

# 启动集群后，还要再特别忽略集群节点的代理
export no_proxy=$no_proxy,$(minikube ip)
export NO_PROXY=$no_proxy,$(minikube ip)
