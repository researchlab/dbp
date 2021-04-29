#!/bin/sh

# change time zone
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# load as root
# sudo timedatectl set-timezone Asia/Shanghai

# disable firewalld 
iptables -F
systemctl stop firewalld 
systemctl disable firewalld 

# disable selinux 
sudo sed -i 's+SELINUX=enforcing+SELINUX=disabled+' /etc/selinux/config
setenforce 0

# 开启内核模块
# Enable transparent masquerading and facilitate Virtual Extensible LAN (VxLAN) traffic for communication between Kubernetes pods across the cluster.
modprobe br_netfilter 

# 同步时间
# 方案一
# yum install ntpdate -y
# ntpdate http://cn.pool.ntp.org

# 方案二
# centos8 默认时间更新方案
yum install -y chrony 
systemctl enable --now chronyd
chronyc sources && timedatectl

# 增加网络转发
# 桥接的IPV4流量传递到iptables 的链
# Set bridged packets to traverse iptables rules.
# enable iptable kernel parameter
cat>/etc/sysctl.d/k8s.conf<<EOF
net.bridge.bridge-nf-call-iptables=1	# 节点上的iptables能够正确地查看桥接流量
net.bridge.bridge-nf-call-ip6tables=1	# 节点上的iptables能够正确地查看桥接流量
# 启用IP路由转发功能
net.ipv4.ip_forward = 1 # 主要是目的是 当linux主机有多个网卡时一个网卡收到的信息是否能够传递给其他的网卡 如果设置成1 的话 可以进行数据包转发 可以实现VxLAN 等功能, 如果设置为0 则不能转发ip
EOF

sysctl -p /etc/sysctl.d/k8s.conf

# disable swap
swapoff -a
sed -i 's+/swapfile+#/swapfile+' /etc/fstab
echo vm.swappiness=0 >> /etc/sysctl.conf
sysctl -p

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
# In the newest RHEL 8.3 , nf_conntrack_ipv4 and nf_conntrack_ipv6 are merged together into the nf_conntrack kernel module. So the check in roles/kubernetes/node/tasks/main.yml should be updated
# https://github.com/kubernetes-sigs/kubespray/issues/6934
cat>/etc/modules-load.d/ipvs.conf<<EOF
# Load IPVS at boot
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack
EOF

systemctl enable --now systemd-modules-load.service

# 确认内核模块加载成功
lsmod |grep -e ip_vs -e nf_conntrack_ipv4

# 安装ipset、ipvsadm
yum install -y ipset ipvsadm


# update docker repo
wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo

# install useful tools
# install kmod and ceph-common for rook
# yum-utils提供了yum-config-manager工具；device-mapper-persisten-data及lvm2则是devicemapper储存驱动所需要的包
yum install -y yum-utils device-mapper-persistent-data lvm2 wget curl conntrack-tools vim net-tools telnet tcpdump bind-utils 
# yum install -y kmod ceph-common dos2unix

# install k8s components
cat>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

sudo yum makecache 
yum install -y docker-ce kubelet-1.20.0 kubeadm-1.20.0 kubectl-1.20.0

mkdir -p /etc/docker/
cat>/etc/docker/daemon.json<<EOF
{
  "registry-mirrors" : [
	"https://reg-mirror.qiniu.com",
	"https://hub-mirror.c.163.com",
	"https://mirror.ccs.tencentyun.com",
	"https://docker.mirrors.ustc.edu.cn",
	"https://dockerhub.azk8s.cn",
	"https://registry.docker-cn.com"
  ]
}
EOF

systemctl start docker 
systemctl enable docker 

systemctl enable kubelet

# permit root remote login 
sed -i 's+#PermitRootLogin yes+PermitRootLogin yes+' /etc/ssh/sshd_config
sed -i 's+#PermitEmptyPasswords no+PermitEmptyPasswords yes+' /etc/ssh/sshd_config
sed -i 's+PasswordAuthentication no+PasswordAuthentication yes+' /etc/ssh/sshd_config
