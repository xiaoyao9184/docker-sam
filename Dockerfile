ARG BASE_IMAGE=python:3.10
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE=cpu
ARG CUDA_VERSION=none
# replace opencv-pytho with opencv-python-headless
ARG OPENCV_INSTALL=opencv-python-headless pycocotools matplotlib onnxruntime onnx
# default use cpu
ARG PYTORCH_INSTALL=torch==2.1.2 torchvision==0.16.2 --index-url https://download.pytorch.org/whl/cpu


FROM alpine:3.18 as download
ARG MODEL_CHECKPOINT
RUN mkdir -p /usr/src && wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth


FROM ${BASE_IMAGE}
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE
ARG OPENCV_INSTALL
ARG PYTORCH_INSTALL

### Segment-Anything ###
COPY segment-anything /usr/src/segment-anything
COPY --from=download /usr/src/${MODEL_CHECKPOINT}.pth /usr/src/segment-anything/
WORKDIR /usr/src/segment-anything

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --upgrade pip && \
    pip install ${OPENCV_INSTALL} && \
    pip install ${PYTORCH_INSTALL} && \
    pip install -e .

ENV MODEL_CHECKPOINT=${MODEL_CHECKPOINT}
ENV MODEL_TYPE=${MODEL_TYPE}
ENV DEVICE_TYPE=${DEVICE_TYPE}
