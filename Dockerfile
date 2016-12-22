FROM ubuntu:xenial

ENV CONTAO_VERSION 3.5.20
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN apt-get update
RUN apt-get install -y curl zip unzip
RUN apt-get install -y nginx
RUN apt-get install -y php php-dom php-gd php-curl php-intl php-mbstring php-mysql
RUN apt-get install -y php-fpm
RUN apt-get install -y supervisor
RUN apt-get install -y git

RUN rm -rf /var/www/html/ && git clone -b ${CONTAO_VERSION} --single-branch https://github.com/contao/core /var/www/html
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN cd /var/www/html && composer install
RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /var/log/supervisor /run/php
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/sites-enabled/default

WORKDIR /var/www/html
HEALTHCHECK CMD curl --fail http://127.0.0.1/ || exit 1
EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"]
