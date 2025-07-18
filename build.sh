#!/bin/bash

# Mission Planner Docker Build Script
# This script builds the Docker image for Mission Planner

set -e

IMAGE_NAME="mission-planner"
TAG="latest"

echo "Building Mission Planner Docker image..."
echo "Image: ${IMAGE_NAME}:${TAG}"

# Build the Docker image
docker build -t "${IMAGE_NAME}:${TAG}" .

echo "Build completed successfully!"
echo "Image '${IMAGE_NAME}:${TAG}' is ready to use."
echo ""
echo "To run the container, execute: ./run.sh"
