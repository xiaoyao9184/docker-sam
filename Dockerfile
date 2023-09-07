FROM python:3.10 as bundle
ARG MODEL_CHECKPOINT

### Segment-Anything ###
COPY segment-anything /usr/src/segment-anything
WORKDIR /usr/src/segment-anything
RUN pip install --upgrade pip && \
    pip install --no-cache-dir opencv-python-headless pycocotools matplotlib onnxruntime onnx torch torchvision torchaudio numpy && \
    pip install --no-cache-dir -e . && \
    wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth

WORKDIR /usr/src/segment-anything