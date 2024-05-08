#!/bin/bash

CURRENT_INSTANCE=$(docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")

if [ "$CURRENT_INSTANCE" ]; then
    docker rm $(docker stop "$CURRENT_INSTANCE")
fi

docker pull "$IMAGE_NAME"

CONTAINER_EXISTS=$(docker ps -a | grep node_app)
if [ "$CONTAINER_EXISTS" ]; then
    docker rm "article_list_app"
fi

docker create -p 8080:8080 -p 8443:8443 --name node_app "$IMAGE_NAME"

echo "$PRIVATE_KEY" > privatekey.pem
echo "$SERVER" > server.crt

docker cp ./privatekey.pem "node_app:/privatekey.pem"
docker cp ./server.crt "node_app:/server.crt"

docker start "article_list_app"
