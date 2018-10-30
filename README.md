# docker env for apps

- basic usages of docker-compose 
  - `docker-compose up -d` 部署运行;
  - `docker-compose pause service_name` 可以模拟对应的`service`容器实例不可用;
  - `docker-compose pause service_name` 可以模拟对应的`service`容器实例不可用;
  - `docker-compose unpause service_name` 将暂停的`service`容器实例恢复运行;
  - `docker-compose config` 可查看完整的编排内容;

## redis(docker) 

- latest stable redis: 5.0

- redis 
	- hub: https://hub.docker.com/_/redis/

- rebloom (redis with bloomfilter plugin)
	- dockerfile: https://github.com/RedisLabsModules/rebloom
	- docker: docker pull redislabs/rebloom

## mysql(docker)

- latest stable mysql: 8.0
