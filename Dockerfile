FROM php:8.3-fpm
WORKDIR /var/www

RUN apt-get udpate -y && apt-get install -y \
    libicu-dev \
    libmysql-dev \
    unzip zip \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpjeg62-turbo-dev \

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install gettext intl pdo_mysql gd zip dom 

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd
