FROM python:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN python3 -m pip install ansible

RUN apt-get update && \
    apt-get install -y curl git && \
    rm -rf /var/lib/apt/lists/*
