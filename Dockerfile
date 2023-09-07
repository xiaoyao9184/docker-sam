FROM python:3.10 as download
ARG MODEL_CHECKPOINT
RUN wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth

FROM python:3.10
ARG MODEL_CHECKPOINT

### Segment-Anything ###
COPY segment-anything /usr/src/segment-anything
WORKDIR /usr/src/segment-anything
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --upgrade pip && \
    pip install opencv-python-headless pycocotools matplotlib onnxruntime onnx torch torchvision torchaudio numpy && \
    pip install -e .
COPY --from=download /usr/src/${MODEL_CHECKPOINT}.pth /usr/src/segment-anything/
