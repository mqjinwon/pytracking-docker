# PyTracking Docker Setup

This repository contains the necessary files to build and run a Docker container for pytracking.

## Prerequisites

- Docker installed on your system

## Build Docker Image

To build the Docker image, run the following command in the root directory of this project:

```bash
docker build -t pytracking:latest .
```

## Run Docker Container

To run the Docker container, use the following command:

```bash
docker run -it --name pytracking \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v /usr/lib/nvidia-graphics-drivers:/usr/lib/nvidia-graphics-drivers \
    --net=host \
    --ipc=host \
    --device /dev/dri \
    --device=/dev/video0:/dev/video0 \
    --device=/dev/video1:/dev/video1 \
    --device=/dev/media0:/dev/media0 \
    pytracking:latest
```

## Running PyTracking

Once inside the Docker container, you can start the webcam tracking with the following commands:

```bash
cd pytracking
python run_webcam.py dimp dimp18
```
