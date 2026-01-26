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
- db_password.txt
- db_root_password.txt
- wp_admin_password.txt
- wp_user_password.txt

The `srcs/.env` file only contains non-sensitive configuration values:

##### Domain
- DOMAIN_NAME

##### MariaDB
- MYSQL_DATABASE
- MYSQL_USER

##### WordPress
- WP_DB_NAME
- WP_DB_USER
- WP_DB_HOST
- WP_TITLE
- WP_ADMIN_USER
- WP_ADMIN_EMAIL
- WP_USER
- WP_USER_EMAIL

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

```bash
make logs-wordpress
make logs-mariadb
make logs-nginx
```