FROM debian:trixie

RUN apt-get update && apt-get install -y nginx \
    && apt-get clean

COPY conf/static.conf /etc/nginx/conf.d/default.conf
COPY website/ /var/www/static/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
