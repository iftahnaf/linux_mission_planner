# Mission Planner Docker

This project provides a containerized version of ArduPilot Mission Planner running on Ubuntu with Mono framework.

## Overview

Mission Planner is a full-featured ground station application for ArduPilot autopilots. This Docker setup allows you to run Mission Planner in a containerized environment, making it easy to deploy and manage across different systems.

## Components

- **Ubuntu Latest**: Base operating system
- **Mono Framework**: Runtime environment for .NET applications on Linux
- **Mission Planner**: Latest version downloaded from ArduPilot firmware repository

## Docker Image

The Docker image is automatically built and published to GitHub Container Registry (GHCR) on every push to the master branch. You can:

- **Pull the latest image**: `docker pull ghcr.io/iftahnaf/linux_mission_planner:latest`
- **View package details**: Visit [GitHub Packages](https://github.com/iftahnaf/linux_mission_planner/pkgs/container/linux_mission_planner)
- **Use specific versions**: Tagged releases are available with semantic versioning

## Features

- Automated download of the latest Mission Planner release
- Complete Mono runtime environment
- X11 forwarding support for GUI display
- USB device access for connecting to flight controllers
- Privileged mode support for hardware access

## Files

- `Dockerfile`: Container definition
- `build.sh`: Script to build the Docker image
- `run.sh`: Script to run the container with proper configuration
- `README.md`: This documentation

## Prerequisites

- Docker installed and running
- X11 server running (for GUI display)
- USB ports accessible (for flight controller connection)

## Quick Start

### Option 1: Use Pre-built Image from GitHub Container Registry

1. Pull and run the latest image:
   ```bash
   docker run -it --rm --privileged \
     -e DISPLAY=$DISPLAY \
     -e QT_X11_NO_MITSHM=1 \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     -v /dev:/dev \
     --device-cgroup-rule='c *:* rmw' \
     --network host \
     ghcr.io/iftahnaf/linux_mission_planner:latest
   ```

2. Or use the convenient run script (automatically pulls latest image):
   ```bash
   ./run.sh
   ```

### Option 2: Build Locally

1. Build the Docker image:
   ```bash
   ./build.sh
   ```

2. Run Mission Planner:
   ```bash
   ./run.sh
   ```

## Usage

The container will start Mission Planner automatically when launched. You can connect flight controllers via USB, and the GUI will be displayed on your host system through X11 forwarding.

## Troubleshooting

- If GUI doesn't appear, ensure X11 forwarding is properly configured
- For USB device issues, verify the container has proper privileges
- Check that your X server allows connections from Docker containers

## Notes

- The container runs in privileged mode to access USB devices
- X11 socket is mounted for GUI display
- All necessary environment variables are set for proper operation
- Docker images are automatically built and published via GitHub Actions
- Multi-architecture support: AMD64 and ARM64 platforms
