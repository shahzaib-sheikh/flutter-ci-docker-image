FROM node:10

LABEL maintainer "Shahzaib Sheikh <shahzaib4213@gmail.com>"

ARG AWS_CLI_VERSION=1.16.98

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
            python \
            python-pip \
            python-setuptools \
            python-dev \
            jq \
            git \
            groff \
            less \
            rsync \
            curl \
            wget \
            libgconf-2-4 \
            gdb \
            libstdc++6 \
            libglu1-mesa \
            fonts-droid-fallback \
            lib32stdc++6 \
            # python3 \
            psmisc \
    ; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Run flutter doctor
RUN flutter doctor -v

# Copy the app files to the container
COPY . /usr/local/bin/app

# Set the working directory to the app files within the container
WORKDIR /usr/local/bin/app


RUN set -ex; \
    pip install --no-cache-dir awscli==$AWS_CLI_VERSION; \
    rm -rf /root/.cache/pip/*

WORKDIR /root
VOLUME /root/.aws

ENTRYPOINT [ "aws" ]
CMD ["--version"]