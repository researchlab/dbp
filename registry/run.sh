#!/bin/bash 

docker pull registry

docker run -d -p 5000:5000 -v $(pwd):/var/lib/registry --restart always --name registry registry:2 
