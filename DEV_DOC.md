# Developer Documentation — Inception

This document explains how to set up, build, run, manage, and persist data for the Inception project.

---

## 1. Environment Setup

### Prerequisites
Before starting, ensure the following tools are installed:

- Docker — https://docs.docker.com/get-started/get-docker/
- Docker Compose — https://docs.docker.com/compose/install
- GNU Make — https://www.gnu.org/software/make/#download
- A Unix-based system (Linux / macOS)

Verify installation:
```bash
docker --version
docker compose version
make --version
```

### Host Configuration
Add the project domain to your `/etc/hosts` file:

```txt
127.0.0.1   yourlogin.42.fr
```

This allows local access to the WordPress site via HTTPS.

### Project Structure

```bash
.
├── Makefile
├── DEV_DOC.md
├── README.md
├── USER_DOC.md
├── secrets/
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        └── mariadb/
```

### Environment Variables
All non-sensitive configuration values are stored in `srcs/.env`.

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

### Secrets Management

Sensitive data is handled using Docker secrets.
Secrets are stored as plain text files in the `secrets/` directory:
| Secret name         | File                    | Usage                  |
| ------------------- | ----------------------- | ---------------------- |
| `db_root_password`  | `db_root_password.txt`  | MariaDB root password  |
| `db_password`       | `db_password.txt`       | WordPress DB user      |
| `wp_admin_password` | `wp_admin_password.txt` | WordPress admin user   |
| `wp_user_password`  | `wp_user_password.txt`  | WordPress regular user |

These secrets are mounted inside containers at runtime and never committed to environment variables or images.

## 2. Run the project

### Build and Start Containers

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

### Makefile Targets
- `make` / `make up`: Build and start the infrastructure
- `make down`: Stop and remove containers
- `make stop`: Stop containers without removing them
- `make start`: Restart stopped containers
- `make restart`: Restart the whole stack
- `make clean`: Remove containers and volumes
- `make fclean`: Full cleanup (images, volumes, data)
- `make re`: Rebuild everything from scratch

## 3. Docker Architecture

### Services

The infrastructure consists of three containers:
- **Nginx:** HTTPS reverse proxy serving WordPress
- **WordPress:** PHP-FPM application with automated setup via WP-CLI
- **MariaDB:** Relational database for WordPress data

### Network
All containers communicate through a custom Docker bridge network:

```yaml
networks:
  docker-network:
    driver: bridge
```

### Checking Containers and Logs

- Container Status: `make ps` or `docker ps`
- Logs:
	- `make logs`:  All containers logs
	- `make logs-nginx`: Nginx logs only
	- `make logs-wordpress`: WordPress logs only
	- `make logs-mariadb`: MariaDB logs only

## 4. Data Persistence

### Volumes Overview

The project uses bind-mounted Docker volumes for persistence.
| Volume    | Container path   | Host path               | Purpose         |
| --------- | ---------------- | ----------------------- | --------------- |
| `wp_data` | `/var/www/html`  | `/home/login/data/wp` | WordPress files |
| `db_data` | `/var/lib/mysql` | `/home/login/data/db` | MariaDB data    |

### Host Data Directories
Directories are created automatically by the Makefile:
```bash
/home/login/data/wp
/home/login/data/db
```

They persist even if containers are stopped or removed.
⚠️ Running `make fclean` deletes these directories permanently.