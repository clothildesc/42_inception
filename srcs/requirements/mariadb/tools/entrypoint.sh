#!/bin/bash
set -e

# Vérifier que les variables sont définies
: "${MYSQL_DATABASE:?Variable non définie}"
: "${MYSQL_USER:?Variable non définie}"
: "${MYSQL_PASSWORD:?Variable non définie}"
: "${MYSQL_ROOT_PASSWORD:?Variable non définie}"

# Substituer les variables dans init.sql
envsubst < /docker-entrypoint-initdb.d/init.sql > /tmp/init.sql

# Initialiser la base si elle n'existe pas
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
		echo "Initializing database..."
		mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock &
		pid="$!"
		sleep 5
		mariadb < /tmp/init.sql
		kill "$pid"
		wait "$pid"
fi

# Lancer MariaDB en foreground
exec mysqld --bind-address=0.0.0.0
