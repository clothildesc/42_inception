#!/bin/bash
set -e

WP_PATH="/var/www/html"

# Lire les mots de passe depuis secrets
export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
export WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Attendre que MariaDB soit pret
until mariadb -h"$WP_DB_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" "$MYSQL_DATABASE" >/dev/null 2>&1; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Verifie si WordPress est deja installe
if [ -f "$WP_PATH/wp-config.php" ]; then
    exec php-fpm8.4 -F
fi

# Copie du fichier exemple
cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php

# Remplacement dynamique des valeurs DB
sed -i "s|database_name_here|${MYSQL_DATABASE}|" $WP_PATH/wp-config.php
sed -i "s|username_here|${MYSQL_USER}|" $WP_PATH/wp-config.php
sed -i "s|password_here|${MYSQL_PASSWORD}|" $WP_PATH/wp-config.php
sed -i "s|localhost|mariadb|" $WP_PATH/wp-config.php

# Configuration Redis
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i \
define('WP_REDIS_HOST', 'redis');\n\
define('WP_REDIS_PORT', 6379);\n\
define('WP_CACHE', true);\n" $WP_PATH/wp-config.php

# Installation WordPress
wp core install \
    --allow-root \
    --path=$WP_PATH \
    --url="https://${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

# Creation d'un autre utilisateur
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --allow-root \
    --role=author \
    --user_pass="${WP_USER_PASSWORD}" \
    --path=$WP_PATH

# Installation et activation de Redis Object Cache
wp plugin install redis-cache \
    --activate \
    --allow-root \
    --path=$WP_PATH

# Lancement PHP-FPM en foreground (Docker requirement)
exec php-fpm8.4 -F
