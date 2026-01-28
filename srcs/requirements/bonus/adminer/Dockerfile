FROM debian:trixie

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    wget \
    && apt-get clean

ARG ADMINER_VERSION=4.8.1

RUN mkdir -p /var/www/adminer && \
    wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php \
    -O /var/www/adminer/index.php

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

WORKDIR /var/www/adminer

EXPOSE 9000

CMD ["php-fpm8.4", "-F"]
