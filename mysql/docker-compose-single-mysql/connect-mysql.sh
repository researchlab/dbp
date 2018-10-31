#!/bin/bash

echo pwd:dev123

docker exec -it mysql-db mysql -udev -p --prompt "\u@\d>"


