#!/bin/sh

repo_url=https://registry.hub.docker.com/v1/repositories
image_name=$1

curl -s ${repo_url}/${image_name}/tags | jq . | grep name | awk '{print $2}' | sed -e 's/"//g'
#curl -s ${repo_url}/${image_name}/tags 
