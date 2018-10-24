#!/bin/bash

docker run -itd --name redisbloomfilter -p7001:6379 -v ~/workbench/docker/redis/conf/redis-rebloom.conf:/etc/redis/redis.conf redislabs/rebloom redis-server /etc/redis/redis.conf
