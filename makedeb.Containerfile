FROM ubuntu:latest

RUN apt update && \
    apt install -y curl jq git cargo cmake desktop-file-utils pkg-config python3 rustc nodejs gpg && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L 'https://proget.makedeb.org/debian-feeds/makedeb.pub' | gpg --dearmor | tee /usr/share/keyrings/makedeb-archive-keyring.gpg 1> /dev/null && \
    echo 'deb [signed-by=/usr/share/keyrings/makedeb-archive-keyring.gpg arch=all] https://proget.makedeb.org/ makedeb main' | tee /etc/apt/sources.list.d/makedeb.list && \
    apt update && apt install -y makedeb && rm -rf /var/lib/apt/lists/*
