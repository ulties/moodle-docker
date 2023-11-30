FROM php:8.0-apache

RUN apt-get update
RUN apt-get install -y git

RUN a2enmod rewrite

RUN git clone -b MOODLE_403_STABLE git://git.moodle.org/moodle.git /var/www/html

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# add php_extension: zip
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip

# add php_extension: gd
RUN apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

# add php_extension: intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install intl

# add php_extension: soap
RUN apt-get install -y libxml2-dev
RUN docker-php-ext-install soap

# add php_extension: exif
RUN docker-php-ext-install exif

# Make max_input_vars = 10000
RUN echo "max_input_vars = 10000" >> /usr/local/etc/php/conf.d/docker-php-max-vars.ini

# PHP opcode caching improves performance and lowers memory requirements, OPcache extension is recommended and fully supported.
RUN docker-php-ext-install opcache

# Copy config
COPY config.php /var/www/html/config.php

EXPOSE 80

# Copy the entry script
#COPY entrypoint.sh /entrypoint.sh

# Set the script as the entry point
#ENTRYPOINT ["/entrypoint.sh"]
