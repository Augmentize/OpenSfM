FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install apt-getable dependencies
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    cmake \
    git \
    libeigen3-dev \
    libopencv-dev \
    libceres-dev \
    python3-dev \
    python3-numpy \
    python3-opencv \
    python3-pip \
    python3-pyproj \
    python3-scipy \
    python3-yaml \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install packages using pip
RUN pip3 install cloudpickle==0.4.0 \
    exifread==2.1.2 \
    joblib==0.14.1 \
    matplotlib==3.3.4 \
    pyproj==2.5.0 \
    pytest==3.0.7 \
    scipy==1.10.1 \
    six==1.16.0 \
    wheel==0.40.0

# Clone the repository
RUN git clone --recursive https://github.com/mapillary/OpenSfM /source/OpenSfM

WORKDIR /source/OpenSfM

RUN git submodule update --init --recursive && \
    pip3 install -r requirements.txt && \
    python3 setup.py build

# Open a shell
CMD ["/bin/bash"]
