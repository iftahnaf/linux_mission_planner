FROM ubuntu:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add Mono repository and install Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update && \
    apt-get install -y mono-complete && \
    rm -rf /var/lib/apt/lists/*

# Create application directory
WORKDIR /opt/missionplanner

# Download and extract Mission Planner
RUN wget https://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-latest.zip && \
    unzip MissionPlanner-latest.zip && \
    rm MissionPlanner-latest.zip

# Set the entrypoint to run Mission Planner using Mono
ENTRYPOINT ["mono", "/opt/missionplanner/MissionPlanner.exe"]