FROM debian:latest

EXPOSE 3000

COPY . /var/www/api/

WORKDIR /var/www/api/

COPY ./composer.json /var/www/api

# install required packages
RUN apt update
RUN apt upgrade
RUN apt install composer npm php8.2-curl php8.2-mysql openssl -y

RUN npm install
RUN npm run build

COPY ./php.ini /etc/php/8.2/cli/

ENV COMPOSER_ALLOW_SUPERUSER=1

CMD npm run dev