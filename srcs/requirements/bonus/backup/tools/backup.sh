#!/bin/bash
set -e

export MYSQL_PASSWORD=$(cat /run/secrets/db_password)

# Creation de copie de la base WP horodate pour eviter ecrasement
mysqldump \
  -h "$WP_DB_HOST" \
  -P "${WP_DB_PORT:-3306}" \
  -u "$WP_DB_USER" \
  -p"$MYSQL_PASSWORD" \
  "$WP_DB_NAME" \
  > /backups/db_$(date +%F_%H-%M).sql
