# User Documentation — Inception

This document explains how to use, access, and verify the Inception Docker stack (Nginx + WordPress + MariaDB).

---

## 1. Services provided

### Nginx (HTTPS Reverse Proxy)
- Serves the website on port 443.
- Forwards PHP requests to WordPress (PHP-FPM).
- Uses SSL certificates.

### WordPress (PHP-FPM)
- Runs the WordPress website on port 9000 (internal).
- Automatically installs WordPress using WP-CLI.

### MariaDB
- Stores WordPress data (users, posts, settings).
- Uses a persistent Docker volume to keep data.


## 2. Run the project

### Start and stop the project

Run from the project root:

```bash
make
```

This will:
1. Build all Docker images
2. Create the required volumes
3. Create the Docker network
4. Start Nginx, WordPress (PHP-FPM), and MariaDB containers

The site becomes available at:
👉 https://yourlogin.42.fr

- Stop and clean containers : `make clean`
- Full cleanup (including volumes) : `make fclean`
- Rebuild everything : `make re`

### Accessing the website

Add this line to your host machine `/etc/hosts` file:

```txt
127.0.0.1   yourlogin.42.fr
```

The site becomes available at:
👉 https://yourlogin.42.fr

The admin panel is available at:
👉 https://yourlogin.42.fr/wp-admin


## 3. Credentials

Sensitive credentials (passwords) are stored securely in the following files: `srcs/secrets/`
- `db_password.txt`
- `db_root_password.txt`
- `wp_admin_password.txt`
- `wp_user_password.txt`

The `srcs/.env` file only contains non-sensitive configuration values:
Example:
```env
DOMAIN_NAME=yourlogin.42.fr

MYSQL_DATABASE=wordpress_db
MYSQL_USER=wp_user

WP_DB_NAME=wordpress_db
WP_DB_USER=wp_user
WP_DB_HOST=mariadb

WP_TITLE=My Inception Website
WP_ADMIN_USER=testadmin
WP_ADMIN_EMAIL=testadmin@42.fr
WP_USER=testuser
WP_USER_EMAIL=testuser@42.fr
```
Passwords are injected into containers using Docker secrets.

⚠️ If you modify .env or any secret file, you must run: `make re`
So the new credentials apply.

## 4. Checking Service Status

### Check running containers

```bash
make ps
```
You should see:
- srcs-nginx
- srcs-wordpress
- srcs-mariadb

### Check logs

- `make logs`:  All containers logs
- `make logs-nginx`: Nginx logs only
- `make logs-wordpress`: WordPress logs only
- `make logs-mariadb`: MariaDB logs only