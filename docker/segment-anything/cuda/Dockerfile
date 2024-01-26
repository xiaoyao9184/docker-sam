ARG BASE_IMAGE=nvidia/cuda:12.1.0-base-ubuntu20.04
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE=cuda
# python
ARG PY_VERSION=3.10
# opencv: replace opencv-python with opencv-python-headless
ARG OPENCV_INSTALL=opencv-python-headless pycocotools matplotlib onnxruntime onnx
# pytorch: default use cuda
ARG PYTORCH_INSTALL=torch==2.1.2 torchvision==0.16.2 --index-url https://download.pytorch.org/whl/cu121


# Stage 1: Download model
FROM alpine:3.18 as download
ARG MODEL_CHECKPOINT
RUN mkdir -p /usr/src && wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth


# Stage 2: Install sam
FROM ${BASE_IMAGE}
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE
ARG PY_VERSION
ARG OPENCV_INSTALL
ARG PYTORCH_INSTALL

COPY segment-anything /usr/src/segment-anything
COPY --from=download /usr/src/${MODEL_CHECKPOINT}.pth /usr/src/segment-anything/
WORKDIR /usr/src/segment-anything

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install \
        python${PY_VERSION} \
        python3-pip \
        python3-setuptools \
        python3-opencv && \
    rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install --upgrade pip && \
    pip3 install ${OPENCV_INSTALL} && \
    pip3 install ${PYTORCH_INSTALL} && \
    pip3 install -e .

ENV MODEL_CHECKPOINT=${MODEL_CHECKPOINT}
ENV MODEL_TYPE=${MODEL_TYPE}
ENV DEVICE_TYPE=${DEVICE_TYPE}
