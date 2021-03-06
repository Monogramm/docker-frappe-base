FROM python:3.7-alpine

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ARG DOCKERIZE_VERSION=v0.6.1

RUN set -ex; \
    apk add --update \
        wget \
        nodejs \
        nodejs-npm \
        git \
        alpine-sdk \
        linux-headers \
        busybox-suid \
        py3-setuptools \
        python3-dev \
        libffi-dev \
        openntpd \
        screen \
        mariadb-common \
        mariadb-dev \
        mariadb-client \
        postgresql-client \
        postgresql-dev \
        postgresql-libs \
        libxslt \
        libxslt-dev \
        py3-openssl \
        py3-ldap3 \
        tiff-dev \
        jpeg-dev \
        lcms2-dev \
        libwebp-dev \
        zlib-dev \
        freetype-dev \
        xvfb \
        ttf-freefont \
        fontconfig \
        dbus \
        libxext \
        wkhtmltopdf \
    ; \
    mkdir /tmp/.X11-unix; \
    chmod 777 /tmp/.X11-unix; \
    chown root:root /tmp/.X11-unix; \
    npm install -g yarn; \
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin; \
    echo $'#!/usr/bin/env sh\n\
          Xvfb :0 -screen 0 1920x1080x24 -ac +extension GLX +render -noreset & \n\
          DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
          killall Xvfb\
          ' > /usr/bin/wkhtmltopdf; \
    chmod +x /usr/bin/wkhtmltopdf; \
    wkhtmltopdf --version; \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/cache/apk/*; \
    pip install --upgrade setuptools pip pip-tools; \
    pip --version
