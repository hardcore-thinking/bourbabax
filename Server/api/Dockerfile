FROM debian:latest

EXPOSE 3000

COPY . /var/www/api/

WORKDIR /var/www/api/

COPY ./composer.json /var/www/api

# install required packages
RUN apt update
RUN apt upgrade
RUN apt install composer npm php8.2-curl php8.2-mysql php-dom openssl -y

RUN npm install

COPY ./php.ini /etc/php/8.2/cli/

ENV COMPOSER_ALLOW_SUPERUSER=1

CMD php artisan serve --host 0.0.0.0
