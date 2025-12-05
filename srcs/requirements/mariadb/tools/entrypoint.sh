#!/bin/bash
set -e

# Substitue les variables dans init.sql
envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql

# Démarre MariaDB en arrière-plan
mysqld --bind-address=0.0.0.0 &
sleep 5

# Exécute l'init seulement au premier démarrage
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Initializing database..."
    mariadb < /tmp/init.sql
fi

wait

