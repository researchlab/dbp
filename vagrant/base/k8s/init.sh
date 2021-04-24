#!/bin/sh

# disable firewalld 
iptables -F
systemctl stop firewalld 
systemctl disable firewalld 

#disable selinux 
sudo sed -i 's+SELINUX=enforcing+SELINUX=disabled+' /etc/selinux/config
setenforce 0

# 开启内核模块
modprobe br_netfilter 

# 同步时间
# 方案一
# yum install ntpdate -y
# ntpdate http://cn.pool.ntp.org

#方案二
#yum install -y chrony 
#systemctl enable --now chronyd
#chronyc sources && timedatectl

# 增加网络转发
# 桥接的IPV4流量传递到iptables 的链
cat>/etc/sysctl.d/k8s.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl -p /etc/sysctl.d/k8s.conf

# kube-proxy开启ipvs
# 参考：https://github.com/kubernetes/kubernetes/tree/master/pkg/proxy/ipvs
# kuber-proxy代理支持iptables和ipvs两种模式，使用ipvs模式需要在初始化集群前加载要求的ipvs模块并安装ipset工具。另外，针对Linux kernel 4.19以上的内核版本使用nf_conntrack 代替nf_conntrack_ipv4。
# 方案一
# cat>/etc/sysconfig/modules/ipvs.modules<<EOF
# #!/bin/bash
# # Load IPVS at boot
# modprobe -- ip_vs
# modprobe -- ip_vs_rr
# modprobe -- ip_vs_wrr
# modprobe -- ip_vs_sh
# modprobe -- nf_conntrack_ipv4
# EOF

# 方案二
cat>/etc/modules-load.d/ipvs.conf<<EOF
# Load IPVS at boot
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack_ipv4
EOF

systemctl enable --now systemd-modules-load.service

#确认内核模块加载成功
lsmod |grep -e ip_vs -e nf_conntrack_ipv4

#安装ipset、ipvsadm
yum install -y ipset ipvsadm


# disable swap 
swapoff -a 
sed -i 's+/swapfile+#/swapfile+' /etc/fstab
echo vm.swappiness=0 >> /etc/sysctl.conf
sysctl -p

# install k8s components 
yum install -y yum-utils device-mapper-persisten-data lvm2 wget vim net-tools

wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo

cat>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

sudo yum makecache fast 
yum install -y docker-ce kubelet-1.20.0 kubeadm-1.20.0 kubectl-1.20.0

systemctl start docker 
systemctl enable docker 

systemctl start kubelet 
systemctl enable kubelet

# permit root remote login 
sed -i 's+#PermitRootLogin yes+PermitRootLogin yes+' /etc/ssh/sshd_config
sed -i 's+#PermitEmptyPasswords no+PermitEmptyPasswords yes+' /etc/ssh/sshd_config
sed -i 's+PasswordAuthentication no+PasswordAuthentication yes+' /etc/ssh/sshd_config
