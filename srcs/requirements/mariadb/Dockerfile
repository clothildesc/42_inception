# Image de base Debian stable
FROM debian:trixie-slim

# Installation de MariaDB Server et de gettext-base pour envsubst
RUN apt update && apt install -y mariadb-server gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# Copie de la config personnalisee du serveur MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie du script SQL d'initialisation de la bdd
COPY conf/init.sql /docker-entrypoint-initdb.d/

# Creation des dossiers pour le bon fonctionnement de MariaDB
# Attribution des droits au user mysql
RUN mkdir -p /var/run/mysqld /var/lib/mysql \
		&& chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

# Copie du script d'entree qui initialise et lance MariaDB
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# Execution du container avec l'utilisateur mysql (+ safe)
USER mysql

# Script d'entrée qui initialise la bdd, applique les fichiers SQL et lance MariaDB en foreground
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Doc du port interne utilise
EXPOSE 3306
