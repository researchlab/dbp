#!/bin/bash
#docker pull mysql/mysql-server
docker run --name=dev-mysql -d -p 3307:3306 -v ~/workbench/docker/docker-envs/mysql/sqls:/sqls/ -e MYSQL_USER=dev -e MYSQL_PASSWORD=dev123 -e MYSQL_ROOT_PASSWORD=dev123456 -e MYSQL_DATABASE=confluence-db  mysql/mysql-server:5.7
