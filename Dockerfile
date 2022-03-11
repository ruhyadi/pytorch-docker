# syntax=docker/dockerfile:1
FROM nvidia/cuda:10.1-base
FROM python:3.8.12-slim-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
     wget && \
     rm -rf /var/lib/apt/lists/*

RUN mkdir /yolo3d
WORKDIR /yolo3d

# download docker
RUN wget https://github.com/nelson-liu/pytorch-manylinux-binaries/releases/download/v1.8.1/torch-1.8.1+cu101-cp38-cp38-linux_x86_64.whl
RUN wget https://download.pytorch.org/whl/cu101/torchvision-0.9.1%2Bcu101-cp38-cp38-linux_x86_64.whl

# install pytorch
RUN pip install torch-1.8.1+cu101-cp38-cp38-linux_x86_64.whl torchvision-0.9.1+cu101-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.8.1+cu101-cp38-cp38-linux_x86_64.whl; rm torchvision-0.9.1+cu101-cp38-cp38-linux_x86_64.whl

# Minimize image size 
RUN (apt-get autoremove -y; \
     apt-get autoclean -y)

CMD ["bash"]