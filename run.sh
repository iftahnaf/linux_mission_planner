#!/bin/bash

# Mission Planner Docker Run Script
# This script runs the Mission Planner container with all necessary configurations

set -e

IMAGE_NAME="mission-planner"
TAG="latest"
CONTAINER_NAME="mission-planner-container"

echo "Starting Mission Planner container..."

# Check if container is already running
if docker ps -q -f name="${CONTAINER_NAME}" | grep -q .; then
    echo "Container '${CONTAINER_NAME}' is already running."
    echo "Stopping existing container..."
    docker stop "${CONTAINER_NAME}"
    docker rm "${CONTAINER_NAME}"
fi

# Remove existing stopped container if it exists
if docker ps -a -q -f name="${CONTAINER_NAME}" | grep -q .; then
    echo "Removing existing container..."
    docker rm "${CONTAINER_NAME}"
fi

# Set up X11 forwarding
xhost +local:docker

# Run the container with all necessary privileges and configurations
docker run -it \
    --name "${CONTAINER_NAME}" \
    --privileged \
    --rm \
    -e DISPLAY="${DISPLAY}" \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /dev:/dev \
    --device-cgroup-rule='c *:* rmw' \
    --network host \
    "${IMAGE_NAME}:${TAG}"

echo "Mission Planner container has stopped."

# Clean up X11 permissions
xhost -local:docker
