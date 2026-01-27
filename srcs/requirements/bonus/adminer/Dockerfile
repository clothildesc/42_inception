FROM debian:trixie

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    wget \
    && apt-get clean

RUN mkdir -p /var/www/adminer && \
    wget https://www.adminer.org/latest.php -O /var/www/adminer/index.php

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

WORKDIR /var/www/adminer

EXPOSE 9000

CMD ["php-fpm8.4", "-F"]
