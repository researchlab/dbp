#!/bin/sh
docker run \
    --name jira-mysql \
    --restart always \
    -p 3336:3306 \
    -e MYSQL_ROOT_PASSWORD=123456 \
    -v $PWD/data:/var/lib/mysql \
    -v $PWD/logs:/logs \
    -v $PWD/conf:/etc/mysql/conf.d \
    -v $PWD/backup:/backup \
    -d  mysql:5.7
