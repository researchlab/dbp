#!/bin/sh 

#配置hosts解析
cat>/etc/hosts<<EOF
192.168.205.10 k8s01
192.168.205.11 k8s02
192.168.205.12 k8s03
EOF
