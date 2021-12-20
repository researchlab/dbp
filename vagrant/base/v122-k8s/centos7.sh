
# yum 源配置
curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
cat>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# 必备工具
yum install wget jq psmisc vim net-tools telnet yum-utils device-mapper-persistent-data lvm2 git -y

# 关闭防火墙, selinux, dnsmasq, swap
systemctl disable --now firewalld
#systemctl disable --now dnsmasq
#systemctl disable --now NetworkManager

setenforce 0
sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/sysconfig/selinux
sed -i 's#SELINUX=enforcing#SELINUX=disabled#g' /etc/selinux/config

# 关闭swap分区
swapoff -a && sysctl -w vm.swappiness=0
sed -ri '/^[^#]*swap/s@^@#@' /etc/fstab


# 安装ntpdate
rpm -ivh http://mirrors.wlnmp.com/centos/wlnmp-release-centos.noarch.rpm
yum install ntpdate -y

# 时间同步
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'Asia/Shanghai' >/etc/timezone
ntpdate time2.aliyun.com

# 配置定时同步时间
echo '*/5 * * * * ntpdate time2.aliyun.com' >>/etc/crontab

#service crond start    //启动服务
#service crond stop     //关闭服务
#service crond restart  //重启服务
service crond reload   //重新载入配置
service crond status   //查看服务状态

# 配置limit
ulimit -SHn 65535

# 末尾添加如下内容
cat>/etc/security/limits.conf<<EOF
* soft nofile 655360
* hard nofile 131072
* soft nproc 655350
* hard nproc 655350
* soft memlock unlimited
* hard memlock unlimited
EOF

## 内核配置

# 开启内核模块
# Enable transparent masquerading and facilitate Virtual Extensible LAN (VxLAN) traffic for communication between Kubernetes pods across the cluster.
modprobe br_netfilter 

# 安装ipvsadm
yum install ipvsadm ipset sysstat conntrack libseccomp -y

# 配置ipvs模块
cat>/etc/modules-load.d/ipvs.conf<<EOF
ip_vs
ip_vs_lc
ip_vs_wlc
ip_vs_rr
ip_vs_wrr
ip_vs_lblc
ip_vs_lblcr
ip_vs_dh
ip_vs_sh
ip_vs_fo
ip_vs_nq
ip_vs_sed
ip_vs_ftp
ip_vs_sh
nf_conntrack_ipv4
ip_tables
ip_set
xt_set
ipt_set
ipt_rpfilter
ipt_REJECT
ipip
EOF

systemctl enable --now systemd-modules-load.service

#确认内核模块加载成功
lsmod |grep -e ip_vs -e nf_conntrack_ipv4

# 所有节点配置k8s内核
cat>/etc/sysctl.d/k8s.conf<<EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
fs.may_detach_mounts = 1
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_watches=89100
fs.file-max=52706963
fs.nr_open=52706963
net.netfilter.nf_conntrack_max=2310720

net.ipv4.tcp_keepalive_time = 600
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_intvl =15
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_max_orphans = 327680
net.ipv4.tcp_orphan_retries = 3
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.ip_conntrack_max = 65536
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_timestamps = 0
net.core.somaxconn = 16384
EOF
sysctl --system

sudo yum makecache fast

#k8s组件
#yum list kubeadm.x86_64 --showduplicates | sort -r
#yum install kubeadm -y 安装最新版本的kubeadm
yum install -y docker-ce kubeadm kubelet-1.22.0 kubectl-1.22.0

systemctl start docker
# 设置开机启动
#systemctl enable docker
systemctl daemon-reload && systemctl enable --now docker

# 默认配置的pause镜像使用gcr.io仓库，国内可能无法访问，所以这里配置Kubelet使用阿里云的pause镜像
cat>/etc/sysconfig/kubelet<<EOF
KUBELET_EXTRA_ARGS="--pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google_containers/pause-amd64:3.2"
EOF
# 设置开机启动
systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet

# permit root remote login
sed -i 's+#PermitRootLogin yes+PermitRootLogin yes+' /etc/ssh/sshd_config
sed -i 's+#PermitEmptyPasswords no+PermitEmptyPasswords yes+' /etc/ssh/sshd_config
sed -i 's+PasswordAuthentication no+PasswordAuthentication yes+' /etc/ssh/sshd_config
