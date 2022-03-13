# syntax=docker/dockerfile:1
FROM nvidia/cuda:10.2-base
FROM python:3.8.12-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
     wget && \
     rm -rf /var/lib/apt/lists/*

WORKDIR /home

# download docker
RUN wget https://github.com/nelson-liu/pytorch-manylinux-binaries/releases/download/v1.9.0/torch-1.9.0+cu102-cp38-cp38-linux_x86_64.whl
RUN wget https://download.pytorch.org/whl/cu102/torchvision-0.10.0%2Bcu102-cp38-cp38-linux_x86_64.whl

# install pytorch
RUN pip install torch-1.9.0+cu102-cp38-cp38-linux_x86_64.whl torchvision-0.10.0+cu102-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.9.0+cu102-cp38-cp38-linux_x86_64.whl; rm torchvision-0.10.0+cu102-cp38-cp38-linux_x86_64.whl

# Minimize image size 
RUN (apt-get autoremove -y; \
     apt-get autoclean -y)

CMD ["bash"]