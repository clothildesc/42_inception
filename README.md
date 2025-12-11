*This project has been created as part of the 42 curriculum by cscache.*

# Inception

## Description

Inception is a project from the 42 curriculum aimed at introducing students to **modern container-based infrastructure using Docker**.  
The goal is to virtualize a complete WordPress setup — including Nginx, PHP-FPM, and MariaDB — by building each component inside its own Docker container, managed through Docker Compose.

The project requires:

- Building a custom **Nginx** container serving the WordPress site through HTTPS (TLS/SSL).
- Building a **WordPress + PHP-FPM** container with automated installation using WP-CLI.
- Building a **MariaDB** container with secure initialization and persistence.
- Managing data persistence via **Docker Volumes**.
- Running all services inside a dedicated **Docker network** for isolation.
- Automating the environment with a **Makefile**.

This project provides a practical foundation for understanding service-oriented architecture, container orchestration, and infrastructure-as-code principles.


## Instructions

### Requirements

- Docker  
- Docker Compose (plugin version)  
- GNU Make  
- Add the hostname to your system’s `/etc/hosts` file:

```txt
127.0.0.1   cscache.42.fr
```

### Start the project

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


## Project Description & Technical Architecture

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

🔹 **Virtual Machines vs Docker**

| Virtual Machines               | Docker                                |
| ------------------------------ | ------------------------------------- |
| Virtualize a full OS           | Virtualize processes only PHP-FPM     |
| Heavy, slow to boot            | Lightweight and fast                  |
| Large memory & disk footprint  | Minimal resource usage                |
| Strong isolation               | Process-level isolation               |
| Less suited to micro-services  | Ideal for micro-services              |

Docker is used because it provides **portability, modularity, and efficiency**.

🔹 **Secrets vs Environment Variables**

| Environment Variables             | Secrets                             |
| --------------------------------- | ----------------------------------- |
| Easy to use                       | More secure                         |
| Stored in clear text              | Never written to disk unencrypted   |
| Sufficient for local development  | Required in production              |
| Supported by Docker without Swarm | Require Docker Swarm / Kubernetes   |

The project uses **environment variables** because the Inception project runs locally without an orchestrator.

🔹 **Docker Network vs Host Network**

| Bridge Network                           | Host Network                        |
| ---------------------------------------- | ----------------------------------- |
| Isolated from the host                   | Shares host network stack           |
| Each container has its own internal IP   | No internal IP; uses host’s IPd     |
| Services communicate by container name   | Direct access to host ports         |
| More secure                              | Higher risk of port collisions      |

A **bridge network** is required for the project for isolation and container-to-container DNS.

🔹 **Docker Volumes vs Bind Mounts**

| Volumes                           | Bind Mounts                            |
| --------------------------------- | -------------------------------------- |
| Fully managed by Docker           | Direct path to the host filesystem     |
| Stable, portable, optimized       | Sensitive to host configuration issues |
| Ideal for database persistence    | Ideal for development environments     |
| Easy backup and migration         | Can break if host paths changes        |

The project uses **Docker volumes** to persist MariaDB and WordPress data reliably.

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
- Understanding Docker networking, volumes, entrypoints, and process supervision
- Troubleshooting WordPress installation and database initialization
- Improving explanations and documentation clarity
- Reviewing script logic for robustness
