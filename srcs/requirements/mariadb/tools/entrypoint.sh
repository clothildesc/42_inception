#!/bin/bash
set -e

# Démarre MariaDB en arrière-plan
mysqld --bind-address=0.0.0.0 &

# Attends que MariaDB démarre
sleep 5

# Exécute l'init SQL uniquement au premier lancement
if [ ! -d "/var/lib/mysql/inception_db" ]; then
    echo "Initializing database..."
    mariadb < /docker-entrypoint-initdb.d/init.sql
fi

# Garde MariaDB au premier plan
wait

