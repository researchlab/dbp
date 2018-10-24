#!/bin/bash

docker run -itd --name lredis -p7002:6379 -v ~/workbench/docker/redis/conf/redis.conf:/etc/redis/redis.conf redis redis-server /etc/redis/redis.conf
