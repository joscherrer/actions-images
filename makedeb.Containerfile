FROM ubuntu:latest as fetcher

# Install needed packages.
RUN apt-get update && \
    apt-get install -y curl gpg sudo && \
    rm -rf /var/lib/apt/lists/*

# Add makedeb repo.
RUN curl -L "https://proget.makedeb.org/debian-feeds/makedeb.pub" | \
    gpg --dearmor | \
    tee /usr/share/keyrings/makedeb-archive-keyring.gpg 1> /dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/makedeb-archive-keyring.gpg arch=all] https://proget.makedeb.org/ makedeb main" | \
    tee /etc/apt/sources.list.d/makedeb.list

RUN apt-get update && apt-get download makedeb

# Main container
FROM ubuntu:latest

COPY --from=fetcher *.deb .
RUN apt-get update && \
    apt-get install -y ./*.deb && \
    apt-get install -y sudo git shellcheck shfmt cargo rustc && \
    rm -rf /var/lib/apt/lists/* && \
    rm ./*.deb

# Set up default build user.
RUN useradd --uid 1001 --create-home makedeb
RUN echo 'makedeb ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
USER makedeb
