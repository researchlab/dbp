docker etcd cluster 

参数说明
- data-dir 指定节点的数据存储目录，这些数据包括节点ID，集群ID，集群初始化配置，Snapshot文件，若未指定—wal-dir，还会存储WAL文件；
- wal-dir 指定节点的was文件的存储目录，若指定了该参数，wal文件会和其他数据文件分开存储。
- name 节点名称
- initial-advertise-peer-urls 告知集群其他节点url.
- listen-peer-urls 监听URL，用于与其他节点通讯
- advertise-client-urls 告知客户端url, 也就是服务的url
- initial-cluster-token 集群的ID
- initial-cluster 集群中所有节点
- initial-cluster-state 监听客户端状态
- listen-client-urls 监听客户端地址
- initial-cluster-state new 初始化集群 为新节点

使用示例

```

➜  cluster git:(master) ✗ docker-compose -f docker-compose.yml ps
    Name                   Command               State                        Ports
---------------------------------------------------------------------------------------------------------
cluster_e3w_1   ./e3w                            Up      0.0.0.0:8089->8080/tcp
etcd1           /usr/local/bin/etcd -name  ...   Up      0.0.0.0:32805->2379/tcp, 0.0.0.0:32803->2380/tcp
etcd2           /usr/local/bin/etcd -name  ...   Up      0.0.0.0:32804->2379/tcp, 0.0.0.0:32802->2380/tcp
etcd3           /usr/local/bin/etcd -name  ...   Up      0.0.0.0:32801->2379/tcp, 0.0.0.0:32800->2380/tcp

# 集群状态
➜  cluster git:(master) ✗ docker exec -t etcd1 etcdctl member list
ade526d28b1f92f7: name=etcd1 peerURLs=http://etcd1:2380 clientURLs=http://0.0.0.0:2379 isLeader=false
bd388e7810915853: name=etcd3 peerURLs=http://etcd3:2380 clientURLs=http://0.0.0.0:2379 isLeader=true
d282ac2ce600c1ce: name=etcd2 peerURLs=http://etcd2:2380 clientURLs=http://0.0.0.0:2379 isLeader=false
➜  cluster git:(master) ✗ docker exec -t etcd3 etcdctl -C http://etcd1:2379,http://etcd2:2379,http://etcd3:2379 member list
ade526d28b1f92f7: name=etcd1 peerURLs=http://etcd1:2380 clientURLs=http://0.0.0.0:2379 isLeader=false
bd388e7810915853: name=etcd3 peerURLs=http://etcd3:2380 clientURLs=http://0.0.0.0:2379 isLeader=true
d282ac2ce600c1ce: name=etcd2 peerURLs=http://etcd2:2380 clientURLs=http://0.0.0.0:2379 isLeader=false
➜  cluster git:(master) ✗ curl -L http://localhost:32805/v2/members
{"members":[{"id":"ade526d28b1f92f7","name":"etcd1","peerURLs":["http://etcd1:2380"],"clientURLs":["http://0.0.0.0:2379"]},{"id":"bd388e7810915853","name":"etcd3","peerURLs":["http://etcd3:2380"],"clientURLs":["http://0.0.0.0:2379"]},{"id":"d282ac2ce600c1ce","name":"etcd2","peerURLs":["http://etcd2:2380"],"clientURLs":["http://0.0.0.0:2379"]}]}

# 集群使用
➜  cluster git:(master) ✗ curl -L http://localhost:32805/v2/keys/foo -XPUT -d value="Hello foo"
{"action":"set","node":{"key":"/foo","value":"Hello foo","modifiedIndex":20,"createdIndex":20}}
➜  cluster git:(master) ✗ curl -L http://localhost:32805/v2/keys/foo1/foo1 -XPUT -d value="Hello foo1"
{"action":"set","node":{"key":"/foo1/foo1","value":"Hello foo1","modifiedIndex":21,"createdIndex":21}}
➜  cluster git:(master) ✗ curl -L http://localhost:32805/v2/keys/foo2/foo2 -XPUT -d value="Hello foo2"
{"action":"set","node":{"key":"/foo2/foo2","value":"Hello foo2","modifiedIndex":22,"createdIndex":22}}
➜  cluster git:(master) ✗ curl -L http://localhost:32805/v2/keys/foo2/foo21/foo21 -XPUT -d value="Hello foo21"
{"action":"set","node":{"key":"/foo2/foo21/foo21","value":"Hello foo21","modifiedIndex":23,"createdIndex":23}}
➜  cluster git:(master) ✗ curl -L http://localhost:32801/v2/keys/foo
{"action":"get","node":{"key":"/foo","value":"Hello foo","modifiedIndex":20,"createdIndex":20}}
➜  cluster git:(master) ✗ curl -L http://localhost:32801/v2/keys/foo2
{"action":"get","node":{"key":"/foo2","dir":true,"nodes":[{"key":"/foo2/foo2","value":"Hello foo2","modifiedIndex":22,"createdIndex":22},{"key":"/foo2/foo21","dir":true,"modifiedIndex":23,"createdIndex":23}],"modifiedIndex":22,"createdIndex":22}}
➜  cluster git:(master) ✗ curl -L http://localhost:32801/v2/keys/foo2\?recursive\=true
{"action":"get","node":{"key":"/foo2","dir":true,"nodes":[{"key":"/foo2/foo2","value":"Hello foo2","modifiedIndex":22,"createdIndex":22},{"key":"/foo2/foo21","dir":true,"nodes":[{"key":"/foo2/foo21/foo21","value":"Hello foo21","modifiedIndex":23,"createdIndex":23}],"modifiedIndex":23,"createdIndex":23}],"modifiedIndex":22,"createdIndex":22}}
➜  cluster git:(master) ✗ curl -L http://localhost:32801/v2/keys/foo2\?recursive\=false
{"action":"get","node":{"key":"/foo2","dir":true,"nodes":[{"key":"/foo2/foo2","value":"Hello foo2","modifiedIndex":22,"createdIndex":22},{"key":"/foo2/foo21","dir":true,"modifiedIndex":23,"createdIndex":23}],"modifiedIndex":22,"createdIndex":22}}
➜  cluster git:(master) ✗ curl -L http://localhost:32801/v2/keys/foo |json_pp
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    96  100    96    0     0  16000      0 --:--:-- --:--:-- --:--:-- 16000
{
   "node" : {
      "key" : "/foo",
      "modifiedIndex" : 20,
      "value" : "Hello foo",
      "createdIndex" : 20
   },
   "action" : "get"
}
➜  cluster git:(master) ✗
```
