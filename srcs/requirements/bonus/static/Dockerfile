# Image de base Debian stable
FROM debian:trixie

# Installation du serveur web Nginx
RUN apt-get update && apt-get install -y nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copie de la config Nginx dediee au site statique
COPY conf/static.conf /etc/nginx/conf.d/default.conf
COPY website/ /var/www/static/

# Port HTTP utilise par Nginx
EXPOSE 80

# Lancement de Nginx en mode foreground
CMD ["nginx", "-g", "daemon off;"]
