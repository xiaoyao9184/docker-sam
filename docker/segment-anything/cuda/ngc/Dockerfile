ARG BASE_IMAGE=nvcr.io/nvidia/pytorch:23.12-py3
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE=cuda
# replace opencv-python with opencv-python-headless
ARG OPENCV_INSTALL=opencv-python-headless pycocotools matplotlib onnxruntime onnx


# Stage 1: Download model
FROM alpine:3.18 as download
ARG MODEL_CHECKPOINT
RUN mkdir -p /usr/src && wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth


# Stage 2: Install sam
FROM ${BASE_IMAGE}
ARG MODEL_CHECKPOINT
ARG MODEL_TYPE
ARG DEVICE_TYPE
ARG OPENCV_INSTALL

COPY segment-anything /usr/src/segment-anything
COPY --from=download /usr/src/${MODEL_CHECKPOINT}.pth /usr/src/segment-anything/
WORKDIR /usr/src/segment-anything

RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install --upgrade pip && \
    pip3 install ${OPENCV_INSTALL} && \
    pip3 install -e .

ENV MODEL_CHECKPOINT=${MODEL_CHECKPOINT}
ENV MODEL_TYPE=${MODEL_TYPE}
ENV DEVICE_TYPE=${DEVICE_TYPE}
