# User Documentation — Inception

This document explains how to use, access, and verify the Inception Docker stack (Nginx + WordPress + MariaDB).

---

## 1. Services provided

### **Nginx (HTTPS Reverse Proxy)**
- Serves the website on port 443.
- Forwards PHP requests to WordPress (PHP-FPM).
- Uses SSL certificates.

### **WordPress (PHP-FPM)**
- Runs the WordPress website on port 9000 (internal).
- Automatically installs WordPress using WP-CLI.

### **MariaDB**
- Stores WordPress data (users, posts, settings).
- Uses a persistent Docker volume to keep data.

---

## 2. Launch the project

### **Start and stop the project**

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
👉 https://cscache.42.fr

- Stop and clean containers : `make clean`
- Full cleanup (including volumes) : `make fclean`
- Rebuild everything : `make re`

### **Accessing the website**

Add this line to your host machine `/etc/hosts` file:

```txt
127.0.0.1   cscache.42.fr
```

The site becomes available at:
👉 https://cscache.42.fr

The admin panel is available at:
👉 https://cscache.42.fr/wp-admin


## 3. Credentials

All credentials are stored in:

```bash
srcs/.env
```

This file contains:

##### MariaDB
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_ROOT_PASSWORD

##### WordPress
- WP_ADMIN_USER
- WP_ADMIN_PASSWORD
- WP_ADMIN_EMAIL
- WP_USER
- WP_USER_PASSWORD

⚠️ If you change .env, you must run: `make re`
So the new credentials apply.

## 4. Checking that everything works

### Check running containers

```bash
docker ps
```
You should see:
- srcs-nginx
- srcs-wordpress
- srcs-mariadb

### Check logs

```bash
docker logs srcs-nginx-1
docker logs srcs-wordpress-1
docker logs srcs-mariadb-1
```

### Test DB connection

```bash
docker exec -it srcs-wordpress-1 mariadb -h mariadb -u $MYSQL_USER -p
```

### Check WordPress installation

```bash
docker exec -it srcs-wordpress-1 wp core is-installed --allow-root
```

If it prints Success, WordPress is ready.