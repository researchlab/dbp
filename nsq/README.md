
单点部署NSQ (docker-compose )

```shell
docker-compose -f docker-compose-single.yml up -d 
```
说明
```yaml
nsqd:
    image: nsqio/nsq
    hostname: nsqd-node
    command: >
      /nsqd
      -broadcast-address 10.21.71.220 # 注意这里要填写宿主机IP, 如果写localhost  那其实访问的是docker 容器内部的localhost 会导致访问不到数据 
      # 或者这里写成  -broadcat-address nsqd  服务名称
      # 然后在宿主机服务上 /etc/hosts 配置 127.0.0.1 nsqd  暴露服务即可;
      -lookupd-tcp-address nsqlookupd-service:4160
    ports:
      - "4150:4150"
      - "4151:4151"
```

部署NSQ 集群(docker-compose)

```shell
docker-compose -f docker-compose-cluster.yml up -d
```

```yml
nsq-nsqd1:
     image: nsqio/nsq:v1.2.0
     hostname: nsq-nsqd1
     command: /nsqd -tcp-address 0.0.0.0:4150 -data-path /usr/local/nsq/bin/data --http-address 0.0.0.0:4151 -lookupd-tcp-address nsq-nsqlookupd1:4160 -lookupd-tcp-address nsq-nsqlookupd2:4260 -broadcast-address nsq-nsqd1
     volumes:
     - "./data1:/usr/local/nsq/bin/data"
     ports:
     - "4150:4150"
     - "4151:4151"
```
本地hosts 文件配置
因为基于nsqlookupd 的数据发现需要访问broadcast-address 暴露的地址，所以需要配置，同时都需要加上
```shell
cat /etc/hosts 
127.0.0.1 nsq-nsqd1
127.0.0.1 nsq-nsqd2
127.0.0.1 nsq-nsqd3
```

Http 调用的时候 设置地址为如下即可
```
lookupdHTTPAddresses: ['127.0.0.1:4161','127.0.0.1:4261']
http://localhost:4151
```