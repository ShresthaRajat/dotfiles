#!/bin/sh
# to clear docker resources


docker system prune
docker system prune -a

docker images -a
docker images -f dangling=true
docker images purge

docker images -a |  grep "pattern"
docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi
docker images -a
docker rmi $(docker images -a -q)


docker ps -a
docker run --rm image_name


docker ps -a -f status=exited
docker rm $(docker ps -a -f status=exited -q)
