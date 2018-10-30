#!/bin/bash

docker run -itd --name redisbloomfilter -p7001:6379 -v ~/workbench/docker/docker-envs/redis/single-redis-with-bloomfilter/conf/redis-rebloom.conf:/etc/redis/redis.conf redislabs/rebloom redis-server /etc/redis/redis.conf
