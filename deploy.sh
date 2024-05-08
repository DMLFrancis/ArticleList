#!/usr/bin/env bash

# Check if there is an instance running with the image name we are deploying
CURRENT_INSTANCE=$(sudo docker ps -a -q --filter ancestor="$IMAGE_NAME" --format="{{.ID}}")

# If an instance does exist, stop the instance
if [ "$CURRENT_INSTANCE" ]
then
  sudo docker rm $(sudo docker stop $CURRENT_INSTANCE)
fi

# Pull down the instance from Docker Hub
ssh -p 5454 -o StrictHostKeyChecking=no ubuntu@ec2-13-49-231-69.eu-north-1.compute.amazonaws.com "sudo docker pull $IMAGE_NAME"

# Check if a Docker container exists with the name of $CONTAINER_NAME; if it does, remove the container
CONTAINER_EXISTS=$(sudo docker ps -a | grep $CONTAINER_NAME)
if [ "$CONTAINER_EXISTS" ]
then
  sudo docker rm $CONTAINER_NAME
fi

# Run the Docker container
ssh -p 5454 -o StrictHostKeyChecking=no ubuntu@ec2-13-49-231-69.eu-north-1.compute.amazonaws.com "sudo docker run -p 3000:3000 -d --name $CONTAINER_NAME $IMAGE_NAME"
