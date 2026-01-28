#!/bin/bash
set -e

# Lire les secrets depuis les fichiers
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Export temporaire pour envsubst
export MYSQL_ROOT_PASSWORD MYSQL_PASSWORD

# Preparer le socket
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

# Substituer les variables dans init.sql
envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql

#Nettoyer environnement
unset MYSQL_ROOT_PASSWORD MYSQL_PASSWORD

# Initialiser la base si elle n'existe pas
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Initializing database..."
    mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock &
    pid="$!"
    until mysqladmin ping --socket=/var/run/mysqld/mysqld.sock --silent; do
        sleep 1
    done
    mariadb --socket=/var/run/mysqld/mysqld.sock < /tmp/init.sql
    kill "$pid"
    wait "$pid"
fi

# Lancer MariaDB en foreground
exec mysqld --bind-address=0.0.0.0
