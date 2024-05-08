#!/usr/bin/env bash
# CHeck if there is instance running with the image name we are deploying
CURRENT_INSTANCE=$(sudo docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")

# If an instance does exist stop the instance
if [ "$CURRENT_INSTANCE" ]
then
  sudo docker rm $(sudo docker stop $CURRENT_INSTANCE)
fi

# Pull down the instance from dockerhub
sudo docker pull $IMAGE_NAME

# Check if a docker container exists with the name of $CONTAINER_NAME if it does reomve the
CONTAINER_EXISTS=$(sudo docker ps -a | grep article_list_app)
if [ "$CONTAINER_EXISTS" ]
then
  sudo docker rm "article_list_app"
fi

sudo docker create -p 3000:3000 -p 8443:8443 --name article_list_app "$IMAGE_NAME"

echo "$PRIVATE_KEY" > privatekey.pem
echo "$SERVER" > server.crt

docker cp ./privatekey.pem "article_list_app:/privatekey.pem"
docker cp ./server.crt "article_list_app:/server.crt"

docker start "article_list_app"
