etcd 

hub
```
$ docker pull quay.io/coreos/etcd
$ docker pull registry.cn-hangzhou.aliyuncs.com/coreos_etcd/etcd:v3
```
etcd除了支持直接使用etcdctl进行管理和配置外，还支持使用http API接口进行操作。官方给出的文档也比较详细，具体如下：
```
基本操作api: https://github.com/coreos/etcd/blob/6acb3d67fbe131b3b2d5d010e00ec80182be4628/Documentation/v2/api.md
集群配置api: https://github.com/coreos/etcd/blob/6acb3d67fbe131b3b2d5d010e00ec80182be4628/Documentation/v2/members_api.md
鉴权认证api: https://github.com/coreos/etcd/blob/6acb3d67fbe131b3b2d5d010e00ec80182be4628/Documentation/v2/auth_api.md
配置项：https://github.com/coreos/etcd/blob/master/Documentation/op-guide/configuration.md
```
