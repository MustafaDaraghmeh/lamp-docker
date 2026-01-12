FROM php:8.2-apache

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    unzip \
    zip \
    libzip-dev \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
  && docker-php-ext-configure zip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install pdo pdo_mysql zip mysqli bcmath intl gd \
  && pecl install xdebug redis || true \
  && docker-php-ext-enable xdebug redis || true \
  && rm -rf /var/lib/apt/lists/*

# Copy Composer binary from the official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN a2enmod rewrite

# Basic Xdebug config for development (adjust `client_host` as needed)
RUN printf '%s\n' \
  "xdebug.mode=develop,debug" \
  "xdebug.start_with_request=yes" \
  "xdebug.client_host=host.docker.internal" \
  "xdebug.client_port=9003" \
  > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /var/www/html
