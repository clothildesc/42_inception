*This project has been created as part of the 42 curriculum by cscache.*

# Inception

## Description

Inception is a systems and DevOps project from the 42 curriculum designed to introduce **container-based infrastructure using Docker**.

The goal is to deploy a complete and secure **WordPress stack** by containerizing each service independently and orchestrating them with Docker Compose. The project focuses on isolation, reproducibility, security, and data persistence.

The mandatory stack includes:
- **Nginx** as an HTTPS reverse proxy (TLS)
- **WordPress** running with PHP-FPM and automated setup via WP-CLI
- **MariaDB** for persistent data storage

The infrastructure can be extended with **bonus services** such as caching, database administration, file transfer, static content hosting, and backups.

## Instructions

### Requirements

- Docker
- Docker Compose (plugin version)
- GNU Make

Add the project domain to `/etc/hosts`:
```txt
127.0.0.1   yourlogin.42.fr
```

### Running the project

1. Clone the repository:
```bash
    git clone git@github.com:clothildesc/inception.git
    cd inception
```
2. Add credentials and configuration:
- Secrets in `secrets/`
- Environment variables in `srcs/.env` (see USER_DOC.md)
3. Build and start the containers from the project root:

```bash
make
```

This will:
1. Build all Docker images
2. Create volumes and network
3. Start all containers

The site becomes available at:
👉 https://yourlogin.42.fr

- Stop and clean containers : `make clean`
- Full cleanup (including volumes) : `make fclean`
- Rebuild everything : `make re`


## Project Description

### Using Docker

Each component of the infrastructure is fully isolated in its own Docker container.
Every service has:
- A custom Dockerfile
- Its own configuration
- A clearly defined role

Containers communicate only through a Docker bridge network, not via host networking.
This ensures isolation, reproducibility, and portability.

### Project Services
 
| Service               | Description                                                             |
| --------------------- |:-----------------------------------------------------------------------:|
| Nginx                 | Acts as an HTTPS reverse proxy and forwards PHP requests to PHP-FPM     |
| WordPress (PHP-FPM)   | Runs WordPress and handles dynamic PHP execution                        |
| MariaDB               | Stores WordPress data securely                                          |
| Docker Volumes        | Persist data for WordPress and MariaDB                                  |

### Bonus Services

The infrastructure can be extended with additional services:
- Redis (WordPress caching)
- FTP server (file transfers)
- Adminer (database administration)
- Static website (static content hosting)
- Backup service (database backups)

### Communication Flow

```
Client → HTTPS (443) → Nginx → PHP-FPM (9000) → WordPress → MariaDB (3306)
```

All services communicate inside a custom Docker bridge network.

### Technical Comparisons

| Topic                             | Description                                                                                    |
| --------------------------------- | ---------------------------------------------------------------------------------------------- |
| Virtual Machines vs Docker        | VMs are heavyweight with full OS; Docker containers are lightweight and share the host OS.     |
| Secrets vs Environment Variables  | Secrets provide secure storage; environment variables are easier but less secure.              |
| Docker Network vs Host            | Docker networks isolate containers; host network exposes containers directly to host network.  |
| Volumes vs Bind Mounts            | Volumes are managed by Docker and preferred for persistence; bind mounts link host folders.    |

## Resources

### Documentation

- Docker — https://docs.docker.com/
- Docker Compose — https://docs.docker.com/compose/
- WordPress Developer Docs — https://developer.wordpress.org/
- Nginx Documentation — https://nginx.org/en/docs/
- MariaDB Documentation — https://mariadb.com/docs/
- WP-CLI — https://wp-cli.org/

### Use of AI

AI was used for:
- Draft this README file ;)
- Improving explanations and documentation clarity.
- Assist in troubleshooting and optimizing Docker configurations.

### For more details

- Developer documentation: DEV_DOC.md
- User documentation: USER_DOC.md
