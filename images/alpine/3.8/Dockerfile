FROM alpine:3.8

LABEL maintainer="Monogramm Maintainers <opensource at monogramm dot io>"

ENV DOCKERIZE_VERSION v0.6.1

RUN set -ex; \
	apk add --update \
		wget \
		nodejs \
		py-mysqldb \
		git \
		alpine-sdk \
		linux-headers \
		py-setuptools \
		python-dev \
		libffi-dev \
		openntpd \
		screen \
		mariadb-common \
		mariadb-dev \
		mariadb-client \
		postgresql-dev \
		postgresql-libs \
		libxslt \
		libxslt-dev \
		tiff-dev \
		jpeg-dev \
		lcms2-dev \
		libwebp-dev \
		zlib-dev \
		freetype-dev \
		py-pip \
		xvfb \
		ttf-freefont \
		fontconfig \
		dbus \
		libxext \
		wkhtmltopdf \
	; \
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin; \
    echo $'#!/usr/bin/env sh\n\
          Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
          DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
          killall Xvfb\
          ' > /usr/bin/wkhtmltopdf; \
    chmod +x /usr/bin/wkhtmltopdf; \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /var/cache/apk/*; \
    pip install --upgrade setuptools pip
