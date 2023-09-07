FROM scratch as test

ARG MODEL_CHECKPOINT=sam_vit_h_4b8939

FROM python:3.10 as download

RUN pip install --upgrade pip

ENV TZ=Europe/Rome

RUN wget -q -O /usr/src/${MODEL_CHECKPOINT}.pth https://dl.fbaipublicfiles.com/segment_anything/${MODEL_CHECKPOINT}.pth

FROM python:3.10 as bundle

### Segment-Anything ###
COPY segment-anything /usr/src/segment-anything
WORKDIR /usr/src/segment-anything
RUN pip install --no-cache-dir opencv-python-headless pycocotools matplotlib onnxruntime onnx torch torchvision torchaudio numpy && \
    pip install --no-cache-dir -e .

### Importing downloaded weights ###
COPY --from=download /usr/src/* /usr/src/segment-anything

WORKDIR /usr/src/segment-anything