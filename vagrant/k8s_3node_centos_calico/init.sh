#!/bin/sh 

#配置hosts解析
cat>/etc/hosts<<EOF
192.168.206.10 k8s-calico-01
192.168.206.11 k8s-calico-02
192.168.206.12 k8s-calico-03
EOF
