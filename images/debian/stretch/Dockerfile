FROM debian:stretch

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV WKHTMLTOX_VERSION 0.12.5
ENV DOCKERIZE_VERSION v0.6.1

RUN apt-get update; \
    apt-get install -y --allow-unauthenticated \
		sudo \
		wget \
		nodejs \
		python-mysqldb \
		git \
		build-essential \
		python-setuptools \
		python-dev \
		libffi-dev \
		libssl-dev  \
		ntp \
		screen \
		mariadb-common \
		libmariadbclient-dev \
		mariadb-client \
		postgresql-dev \
		postgresql-libs \
		libxslt1.1 \
		libxslt1-dev \
		libcrypto++-dev \
		postfix \
		libtiff5-dev \
		libjpeg8-dev \
		liblcms2-dev \
		libwebp-dev \
		tcl8.6-dev \
		tk8.6-dev \
		python-tk \
		zlib1g-dev \
		libfreetype6-dev \
		python-pip \
		fontconfig \
		libxrender1 \
		libxext6 \
		xfonts-75dpi \
		xfonts-base \
	; \
    rm -rf /var/lib/apt/lists/*; \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${WKHTMLTOX_VERSION}/wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    tar xf wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    mv wkhtmltox/bin/* /usr/local/bin/; \
    rm wkhtmltox-${WKHTMLTOX_VERSION}_linux-generic-amd64.tar.xz; \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    pip install --upgrade setuptools pip
