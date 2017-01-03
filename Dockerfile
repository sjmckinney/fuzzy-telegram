FROM php:5-apache

# Change apache permissions
RUN a2enmod rewrite

# Install curl php, and other utils to facilitate install of composer
RUN apt-get update
RUN apt-get -y install curl git openssl unzip php5-mysql mysql-client
RUN apt-get clean

# Copy contents of project root to apaches default folder
ADD . /var/www/html

# Install PHP Data object (PDO) extensions for mysql
RUN docker-php-ext-install pdo pdo_mysql

# Download Composer; save as composer-setup.php
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php

# Switch to container directory and run file to verify Composer download
RUN /var/www/html/check_composer_download.sh

# Install composer
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Run composer to install project dependencies
RUN composer install

# Start apache
RUN echo  "$(echo '. /var/www/html/.env' | cat - /etc/apache2/envvars)" > /etc/apache2/envvars
CMD exec /usr/sbin/apachectl -D FOREGROUND
