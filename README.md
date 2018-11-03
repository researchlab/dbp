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
  - dockerfile(8.0):https://github.com/docker-library/mysql/blob/master/8.0/Dockerfile
  - dockerfile(5.7):https://github.com/docker-library/mysql/blob/master/5.7/Dockerfile

- mysql/mysql-server
  - hub: https://hub.docker.com/r/mysql/mysql-server/
  - dockerfile(8.0):https://github.com/mysql/mysql-docker/blob/mysql-server/8.0/Dockerfile
  - dockerfile(5.7):https://github.com/mysql/mysql-docker/blob/mysql-server/5.7/Dockerfile
  - references: https://docs.docker.com/samples/library/mysql/

- docker-compose-all-mysql
   - fork from: https://github.com/treetips/docker-compose-all-mysql
   - Support MySQL version,
     - MySQL v5.5
     - MySQL v5.6
     - MySQL v5.7
     - MySQL v8.0
     - mariadb v10.0
     - mariadb v10.1
     - mariadb v10.2
     - mariadb v10.3
   
	 - mysql官方示例数据库: sakila数据库
     - installation: https://dev.mysql.com/doc/sakila/en/sakila-installation.html
     - sakila database zip: https://dev.mysql.com/doc/index-other.html
