*This project has been created as part of the 42 curriculum by cscache.*

# Inception

## Description

Inception is a project from the 42 curriculum aimed at introducing students to **modern container-based infrastructure using Docker**. The goal is to virtualize a complete WordPress setup — including Nginx, PHP-FPM, and MariaDB — by building each component inside its own Docker container, managed through Docker Compose.

The project requires building:
- A **Nginx** container serving the WordPress site through HTTPS (TLS/SSL).
- A **WordPress + PHP-FPM** container with automated installation using WP-CLI.
- A **MariaDB** container with secure initialization and persistence.

## Instructions

### Requirements

- Docker  
- Docker Compose (plugin version)  
- GNU Make  
- Add the hostname to your system’s `/etc/hosts` file:

```txt
127.0.0.1   cscache.42.fr
```

### Running the project

1. Clone the repository:
    
    `git clone git@github.com:clothildesc/inception.git`
    
2. Place your password files in the `secrets/` directory and other variables in a `srcs/.env` file 
(see USER_DOC.md). 
3. Build and start the containers from the project root:

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
