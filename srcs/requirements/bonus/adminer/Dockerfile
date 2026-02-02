# Image de base Debian stable
FROM debian:trixie

# Installation de PHP-FPM, de l’extension MySQL et de wget
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Version d’Adminer a telecharger
ARG ADMINER_VERSION=4.8.1

# Creation du dossier d’Adminer et telechargement du fichier PHP principal
RUN mkdir -p /var/www/adminer && \
    wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php \
    -O /var/www/adminer/index.php

# Copie de la config PHP-FPM personnalisee
COPY conf/www.conf /etc/php/8.4/fpm/pool.d/www.conf

# Definition du repertoire de travail
WORKDIR /var/www/adminer

# Port interne utilise
EXPOSE 9000

# Lancement de PHP-FPM en mode foreground
CMD ["php-fpm8.4", "-F"]
