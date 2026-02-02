# Image de base Debian stable
FROM debian:trixie-slim

# Installation de mariadb-client et de cron
RUN apt-get update && apt-get install -y \
    mariadb-client \
    cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copie du script de sauvegarde de la bdd + attribution des droits
COPY tools/backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Lancement du service cron en mode foreground
CMD ["cron", "-f"]
