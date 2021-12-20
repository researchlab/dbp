##  centos7 内核升级


## 安装内核

```shell
# 下载内核包
# kernel-ml-4.19.12-1.el7.elrepo.x86_64.rpm
# kernel-ml-devel-4.19.12-1.el7.elrepo.x86_64.rpm

# 更新
yum update -y --exclude=kernel*

# 安装内核
# 到kernel 目录下执行如下命令安装内核
yum localinstall -y kernel-ml*
```

## 更改内核启动顺序

```
grub2-set-default 0  && grub2-mkconfig -o /etc/grub2.cfg

grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"
```

## 检查默认内核是不是4.19

```
grubby --default-kernel

[root@centos7 ~]# grubby --default-kernel
/boot/vmlinuz-4.19.12-1.el7.elrepo.x86_64
```

## 重启系统

```
[root@centos7 ~]# uname -sr
Linux 4.19.12-1.el7.elrepo.x86_64
```
