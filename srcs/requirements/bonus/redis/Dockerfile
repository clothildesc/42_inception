FROM debian:trixie

RUN apt-get update && apt-get install -y \
    redis-server \
    && apt-get clean

# Autoriser les connexions reseau (Docker)
RUN sed -i 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf \
 && sed -i 's/^protected-mode yes/protected-mode no/' /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]