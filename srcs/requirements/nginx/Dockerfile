# Image de base Debian stable
FROM debian:trixie

# Installation de Nginx + OpenSSL
RUN apt update && apt install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

# Cree le dossier pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Genere un certificat SSL auto-signe (pour activer HTTPS)
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cscache.42.fr"

# Copie de la config principale Nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copie de la config des virtual hosts (pour servir plusieurs sites avec un serveur)
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Doc du port interne utilise
EXPOSE 443

# Lancement de Nginx en mode foreground
CMD ["nginx", "-g", "daemon off;"]
