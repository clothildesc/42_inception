FROM debian:trixie

RUN apt update && apt install -y nginx openssl

# Cree le dossier pour les certificats SSL
RUN mkdir -p /etc/nginx/ssl

# Genere un certificat auto-signe
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=cscache.42.fr"

# Copie les fichiers de config
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
