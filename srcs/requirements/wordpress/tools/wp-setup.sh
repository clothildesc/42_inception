#!/bin/bash
set -e

WP_PATH="/var/www/html/wordpress"

# Attendre que MariaDB soit pret
sleep 5

# Vérifie si WordPress est déjà installé
if [ -f "$WP_PATH/wp-config.php" ]; then
    exec php-fpm8.2 -F
fi

# 1. Copie du fichier exemple
cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php

# 2. Remplacement dynamique des valeurs DB
sed -i "s|database_name_here|${MYSQL_DATABASE}|" $WP_PATH/wp-config.php
sed -i "s|username_here|${MYSQL_USER}|" $WP_PATH/wp-config.php
sed -i "s|password_here|${MYSQL_PASSWORD}|" $WP_PATH/wp-config.php
sed -i "s|localhost|mariadb|" $WP_PATH/wp-config.php

# 3. Installation WP-CLI
curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp

# 4. Installation WordPress

wp core install \
    --path=$WP_PATH \
    --url="https://${DOMAIN_NAME}" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --skip-email

# 5. Créer un utilisateur supplémentaire
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --role=author \
    --user_pass="${WP_USER_PASSWORD}" \
    --path=$WP_PATH

# 6. Lance PHP-FPM en foreground (Docker requirement)
exec php-fpm8.2 -F

