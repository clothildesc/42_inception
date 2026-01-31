# Image de base Debian stable
FROM debian:trixie

# Installation du serveur FTP vsftpd
RUN apt-get update && apt-get install -y \
    vsftpd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Creation d’un user dedie au service FTP
RUN useradd -m ftpuser

# Creation du repo requis par vsftpd pour le chroot
RUN mkdir -p /var/run/vsftpd/empty

# Copie de la config personnalisee de vsftpd
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Copie du script de confog et d'initialisation FTP
COPY tools/ftp-setup.sh /usr/local/bin/ftp-setup.sh
RUN chmod +x /usr/local/bin/ftp-setup.sh

# Script d'entrée : configure le user, applique les permissions et lance le serveur
ENTRYPOINT ["ftp-setup.sh"]

# Port interne
EXPOSE 21

# Lancement de vsftpd avec la config
CMD ["vsftpd", "/etc/vsftpd.conf"]
