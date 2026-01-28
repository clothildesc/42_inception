FROM debian:trixie

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-redis \
    php-mbstring \
    php-xml \
    php-curl \
    php-gd \
    php-zip \
    php-intl \
    php-soap \
    wget \
    curl \
    mariadb-client \
    && apt-get clean

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

ARG WP_VERSION=6.9

RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz  -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    chown -R www-data:www-data /var/www/html && \
    rm /tmp/wordpress.tar.gz

COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["wp-setup.sh"]
