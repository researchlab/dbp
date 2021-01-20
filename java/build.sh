#!/bin/bash

docker build --no-cache --network=host -f Dockerfile -t researchboy/vscode:1.0-java .
