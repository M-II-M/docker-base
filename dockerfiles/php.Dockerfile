FROM php:8.1-fpm-alpine

WORKDIR /var/www/laravel

RUN apk add --no-cache \
    icu-dev \
    libpng \
    libjpeg-turbo \
    libwebp

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN docker-php-ext-configure intl && docker-php-ext-install intl

RUN apk add --no-cache --virtual build-essentials \
    libpng-dev libwebp-dev libjpeg-turbo-dev freetype-dev && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd && \
    apk del build-essentials && rm -rf /usr/src/php*    


