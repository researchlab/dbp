docker etcd with ui (e3w)

客户端通过 `ETCD_ADVERTISE_CLIENT_URLS` 这个地址和 etcd 建立连接

etcd 命令行界面 etcdctl
etcdctl 是 etcd 提供的命令行界面，可以方便地管理 etcd 服务
```
docker exec $(docker ps -a --filter name=etcd -q) etcdctl put root/service/svc1/key1 val1
docker exec $(docker ps -a --filter name=etcd -q) etcdctl get root/service/svc1/key1
```

e3w 是一个 etcd 的 ui 界面，可以方便地查看和管理当前的 kv 和各节点的状态


github etcd: https://github.com/etcd-io/etcd

github ui 界面 e3w: https://github.com/soyking/e3w

etcd 配置: https://github.com/etcd-io/etcd/blob/master/Documentation/op-guide/configuration.md

docker etcd 镜像: https://hub.docker.com/r/bitnami/etcd

docker e3w 镜像: https://hub.docker.com/r/soyking/e3w

etcd API: https://github.com/etcd-io/etcd/blob/6acb3d67fbe131b3b2d5d010e00ec80182be4628/Documentation/v2/api.md

e3w 配置说明
```
➜  cluster git:(master) ✗ cat /tmp/docker/e3w/conf/config.ini
[app]
port=8080
auth=false

[etcd]
root_key=e3w_test
dir_value=service
addr=etcd:2379
username=
password=
cert_file=
key_file=
ca_file=

```
- addr 填写的是 每个etcd node 的-advertise-client-urls http://etcd1:2379值;

