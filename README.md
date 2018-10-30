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

- mysql
  - hub: https://hub.docker.com/_/mysql/
	- dockerfile(8.0):https://github.com/docker-library/mysql/blob/223f0be1213bbd8647b841243a3114e8b34022f4/8.0/Dockerfile
	- dockerfile(5.7):https://github.com/docker-library/mysql/blob/b7c899673a214df4c8027a498c64eec7145ba479/5.7/Dockerfile

- mysql/mysql-server
  - hub: https://hub.docker.com/r/mysql/mysql-server/
	- dockerfile(8.0):https://github.com/mysql/mysql-docker/blob/mysql-server/8.0/Dockerfile
	- dockerfile(5.7):https://github.com/mysql/mysql-docker/blob/mysql-server/5.7/Dockerfile

