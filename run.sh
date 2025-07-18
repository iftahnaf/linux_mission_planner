#!/bin/bash

# Mission Planner Docker Run Script
# This script runs the Mission Planner container with all necessary configurations

set -e

# Use GHCR image by default, fallback to local image
GHCR_IMAGE="ghcr.io/iftahnaf/linux_mission_planner:latest"
LOCAL_IMAGE="mission-planner:latest"
CONTAINER_NAME="mission-planner-container"

echo "Starting Mission Planner container..."

# Try to use GHCR image first, fallback to local
if docker pull "$GHCR_IMAGE" 2>/dev/null; then
    IMAGE_NAME="$GHCR_IMAGE"
    echo "Using pre-built image from GitHub Container Registry"
else
    IMAGE_NAME="$LOCAL_IMAGE"
    echo "Using local image (run ./build.sh first if not available)"
fi

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
    "${IMAGE_NAME}"

echo "Mission Planner container has stopped."

# Clean up X11 permissions
xhost -local:docker
