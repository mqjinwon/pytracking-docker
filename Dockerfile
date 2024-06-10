FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel

# Install NVIDIA GPG key and add repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
RUN apt-get update && apt-get install -y software-properties-common

# Install basic dependencies
RUN apt-get update && apt-get install -y \
    git wget g++ ninja-build \
    libgl1-mesa-glx libglib2.0-0 \
    libsm6 libxext6 libxrender1

WORKDIR /

# Clone pytracking repository and update submodules
RUN git clone https://github.com/visionml/pytracking.git && \
    cd /pytracking && \
    git submodule update --init

# Install Python dependencies
RUN pip3 install matplotlib pandas tqdm opencv-python \
    tb-nightly visdom scikit-image tikzplotlib gdown \
    cython pycocotools lvis jpeg4py timm

# Set the working directory
WORKDIR /pytracking

# Create networks directory and download models
RUN mkdir -p ./pytracking/networks && \
    gdown https://drive.google.com/uc\?id\=1qgachgqks2UGjKx-GdO1qylBDdB1f9KN -O pytracking/networks/dimp50.pth && \
    gdown https://drive.google.com/uc\?id\=1MAjrRJDCbL0DSjUKFyDkUuYS1-cYBNjk -O pytracking/networks/dimp18.pth

# Create default local files
RUN python -c "from pytracking.evaluation.environment import create_default_local_file; create_default_local_file()" && \
    python -c "from ltr.admin.environment import create_default_local_file; create_default_local_file()"