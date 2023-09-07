FROM scratch as test

FROM python:3.10 as download

RUN pip install --upgrade pip

ENV TZ=Europe/Rome

RUN wget -q -O /usr/src/sam_vit_h_4b8939.pth https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth &&\ 
    wget -q -O /usr/src/sam_vit_l_0b3195.pth https://dl.fbaipublicfiles.com/segment_anything/sam_vit_l_0b3195.pth &&\
    wget -q -O /usr/src/sam_vit_b_01ec64.pth https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth

FROM python:3.10 as bundle

### Segment-Anything ###
COPY segment-anything /usr/src/segment-anything
WORKDIR /usr/src/segment-anything
RUN pip install --no-cache-dir opencv-python-headless pycocotools matplotlib onnxruntime onnx torch torchvision torchaudio numpy && \
    pip install --no-cache-dir -e .

### Importing downloaded weights ###
COPY --from=download /usr/src/* /usr/src/segment-anything

WORKDIR /usr/src/segment-anything