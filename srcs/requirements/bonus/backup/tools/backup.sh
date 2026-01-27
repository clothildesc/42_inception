#!/bin/bash
set -e

export MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mysqldump -h mariadb -u wp_user -p"$MYSQL_PASSWORD" wordpress_db \
  > /backups/db_$(date +%F_%H-%M).sql
