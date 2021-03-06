FROM python:3.5-slim-buster

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ARG NODE_VERSION=12

ENV DEBIAN_FRONTEND="noninteractive"
ARG WKHTMLTOX_VERSION=0.12.4
ARG DOCKERIZE_VERSION=v0.6.1

RUN set -ex; \
    apt-get update; \
    apt-get install -y software-properties-common gnupg2 curl; \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8; \
    add-apt-repository "deb http://ams2.mirrors.digitalocean.com/mariadb/repo/10.5/debian buster main"; \
    curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash -; \
    curl -sS "https://dl.yarnpkg.com/debian/pubkey.gpg" | apt-key add -; \
    apt-get update; \
    apt-get install -y --allow-unauthenticated \
        sudo \
        wget \
        nodejs \
        python-mysqldb \
        git \
        build-essential \
        python3-setuptools \
        python3-dev \
        libffi-dev \
        libssl-dev  \
        ntp \
        screen \
        mariadb-client \
        mariadb-common \
        postgresql-client \
        postgresql-client-common \
        libxslt1.1 \
        libxslt1-dev \
        libcrypto++-dev \
        python3-openssl \
        python3-ldap3 \
        libtiff5-dev \
        libjpeg62-turbo-dev \
        liblcms2-dev \
        libwebp-dev \
        tcl8.6-dev \
        tk8.6-dev \
        python-tk \
        zlib1g-dev \
        libfreetype6-dev \
        fontconfig \
        libxrender1 \
        libxext6 \
        xfonts-75dpi \
        xfonts-base \
    ; \
    mkdir /tmp/.X11-unix; \
    chmod 777 /tmp/.X11-unix; \
    chown root:root /tmp/.X11-unix; \
    npm install -g yarn; \
    rm -rf /var/lib/apt/lists/*; \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${WKHTMLTOX_VERSION}/wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    tar xf wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    mv wkhtmltox/bin/* /usr/local/bin/; \
    rm wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    wkhtmltopdf --version; \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    pip install --upgrade setuptools pip pip-tools; \
    pip --version
