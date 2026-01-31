# Image de base Debian
FROM debian:trixie

# Installation des dépendances necessaires
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
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Telechargement et installation de WP-CLI
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

# Version de WP à installer
ARG WP_VERSION=6.9

# Telechargement et installation de WP :
RUN mkdir -p /var/www/html && \
    wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz  -O /tmp/wordpress.tar.gz && \
    tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 && \
    chown -R www-data:www-data /var/www/html && \
    rm /tmp/wordpress.tar.gz

#Copie de la config PHP-FPM personnalisee + du script de setup WP
COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf
COPY tools/wp-setup.sh /usr/local/bin/wp-setup.sh
RUN chmod +x /usr/local/bin/wp-setup.sh

# Def du repertoire de travail
WORKDIR /var/www/html

# Doc du port interne utilise
EXPOSE 9000

# Script pour attendre que la MariaDB soit dispo, configure WP et lancer PHP-FPM
ENTRYPOINT ["wp-setup.sh"]
