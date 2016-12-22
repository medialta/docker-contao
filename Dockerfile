FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN apt-get update
RUN apt-get install -y curl zip unzip
RUN apt-get install -y nginx
RUN apt-get install -y php php-dom php-gd php-curl php-intl php-mbstring php-mysql
RUN apt-get install -y php-fpm
RUN apt-get install -y supervisor

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN rm -rf /var/www/html/ && composer create-project contao/standard-edition /var/www/html/
RUN chown -R www-data:www-data /var/www/html

RUN mkdir -p /var/log/supervisor /run/php
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/sites-enabled/default

EXPOSE 80
WORKDIR /var/www/html
HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

CMD ["/usr/bin/supervisord", "-n"]
