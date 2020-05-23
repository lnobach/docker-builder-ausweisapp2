

FROM ubuntu:20.04

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    apt-get update && apt-get dist-upgrade -y && apt-get install -y \
    python \
    cmake \
    clang \
    git \
    build-essential \
    mesa-common-dev \
    libx11-dev \
    libxkbcommon-dev \
    libxcb-util-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libpcsclite-dev \
    libfontconfig1-dev \
    libfreetype-dev
RUN echo "build:x:1000:1000:build,,,:/home/build:/bin/bash" >> /etc/passwd && \
    echo "build:x:1000:" >> /etc/group && \
    mkdir /app /workspace /home/build && chown build:build /workspace /home/build
COPY build /app/
USER build
WORKDIR /workspace
ENTRYPOINT [ "/app/build" ]
