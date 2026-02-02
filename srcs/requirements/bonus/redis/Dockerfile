# Image de base Debian stable
FROM debian:trixie-slim

# Installation du serveur Redis
RUN apt-get update && apt-get install -y \
    redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Modification de la config Redis pour autoriser les connexions reseau :
# - bind 0.0.0.0 : autorise les connexions depuis d'autres containers Docker
# - protected-mode no : désactive la protection locale
# - daemonize no : Redis reste en foreground
RUN sed -i 's/^bind .*/bind 0.0.0.0/' /etc/redis/redis.conf \
 && sed -i 's/^protected-mode yes/protected-mode no/' /etc/redis/redis.conf \
 && sed -i 's/^daemonize yes/daemonize no/' /etc/redis/redis.conf

# Port par defaut
EXPOSE 6379

# Lancement du serveur Redis avec la config personnalisee
CMD ["redis-server", "/etc/redis/redis.conf"]