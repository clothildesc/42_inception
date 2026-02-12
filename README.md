# Inception

A complete Docker-based infrastructure to deploy a secure WordPress stack with multiple containerized services.

## 📋 Description

**Inception** is a 42 School systems and DevOps project designed to introduce **container-based infrastructure using Docker**.

The goal is to deploy a complete and secure **WordPress stack** by containerizing each service independently and orchestrating them with Docker Compose. The project focuses on isolation, reproducibility, security, and data persistence.

The mandatory stack includes:
- **Nginx** as an HTTPS reverse proxy (TLS)
- **WordPress** running with PHP-FPM and automated setup via WP-CLI
- **MariaDB** for persistent data storage

The infrastructure can be extended with **bonus services** such as caching, database administration, file transfer, static content hosting, and backups.

**👤 This project was completed as part of the 42 School curriculum.**

## 🛠️ Built With

### Core Technologies
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Docker Compose](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-21759B?style=for-the-badge&logo=wordpress&logoColor=white)
![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)

### Languages & Tools
![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Make](https://img.shields.io/badge/Make-427819?style=for-the-badge&logo=cmake&logoColor=white)

## 🚀 Features

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

## 🔧 Installation

### Prerequisites

- Docker
- Docker Compose (plugin version)
- GNU Make

### Setup

1. Clone the repository:
```bash
git clone https://github.com/clothildesc/42_inception.git
cd 42_inception
```

2. **Configure the domain name**

Add the project domain to `/etc/hosts`:
```bash
sudo nano /etc/hosts
```

Add this line (replace `yourlogin` with your actual login):
```txt
127.0.0.1   yourlogin.42.fr
```

Save and exit (Ctrl+O, Enter, Ctrl+X).

3. **Create secrets directory and add credentials**

Create the secrets directory:
```bash
mkdir -p secrets/
```

Create each secret file with your passwords:
```bash
# Database root password
echo "your_strong_root_password" > secrets/db_root_password.txt

# Database user password
echo "your_strong_db_password" > secrets/db_password.txt

# WordPress admin password
echo "your_wordpress_admin_password" > secrets/wordpress_admin_password.txt

# WordPress database name
echo "wordpress" > secrets/db_name.txt

# WordPress database user
echo "wpuser" > secrets/db_user.txt
```

**Important**: Use strong, unique passwords for each secret!

4. **Configure environment variables**

Create or edit `srcs/.env` file:
```bash
nano srcs/.env
```

Add your configuration (replace with your actual values):
```env
# Domain configuration
DOMAIN_NAME=yourlogin.42.fr

# MySQL/MariaDB configuration
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser

# WordPress configuration
WP_TITLE=My Inception Site
WP_ADMIN_USER=admin
WP_ADMIN_EMAIL=admin@yourlogin.42.fr
WP_URL=https://yourlogin.42.fr

# Optional: WordPress user (non-admin)
WP_USER=user
WP_USER_EMAIL=user@yourlogin.42.fr
```

Save and exit (Ctrl+O, Enter, Ctrl+X).

**Note**: Passwords are NOT stored in `.env` for security reasons - they are in the `secrets/` directory.

5. **Build and start the infrastructure**

```bash
make
```

This will:
1. Build all Docker images from custom Dockerfiles
2. Create Docker volumes for persistence
3. Set up the Docker network
4. Start all containers

The site becomes available at:
👉 **https://yourlogin.42.fr**

### Make Commands
- `make` - Build and start all containers
- `make clean` - Stop and clean containers
- `make fclean` - Full cleanup (including volumes)
- `make re` - Rebuild everything from scratch

## 💻 Usage

### Accessing Services

**WordPress Site:**
- URL: https://yourlogin.42.fr
- Admin URL: https://yourlogin.42.fr/wp-admin
- Username: (from WP_ADMIN_USER in .env)
- Password: (from secrets/wordpress_admin_password.txt)

**Logs and Debugging:**
```bash
# View all container logs
docker compose -f srcs/docker-compose.yml logs

# View specific service logs
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb

# Follow logs in real-time
docker compose -f srcs/docker-compose.yml logs -f
```

**Container Management:**
```bash
# List running containers
docker compose -f srcs/docker-compose.yml ps

# Execute commands in a container
docker compose -f srcs/docker-compose.yml exec wordpress bash
docker compose -f srcs/docker-compose.yml exec mariadb bash

# Restart a specific service
docker compose -f srcs/docker-compose.yml restart nginx
```

## 📊 Technical Comparisons

| Topic                             | Description                                                                                    |
| --------------------------------- | ---------------------------------------------------------------------------------------------- |
| Virtual Machines vs Docker        | VMs are heavyweight with full OS; Docker containers are lightweight and share the host OS.     |
| Secrets vs Environment Variables  | Secrets provide secure storage; environment variables are easier but less secure.              |
| Docker Network vs Host            | Docker networks isolate containers; host network exposes containers directly to host network.  |
| Volumes vs Bind Mounts            | Volumes are managed by Docker and preferred for persistence; bind mounts link host folders.    |

## 🎓 Learning Outcomes

This project teaches:
- ✅ **Docker fundamentals** - Images, containers, volumes, networks
- ✅ **Docker Compose** - Multi-container orchestration
- ✅ **Nginx configuration** - Reverse proxy, TLS/SSL
- ✅ **Database management** - MariaDB setup and security
- ✅ **WordPress deployment** - PHP-FPM, WP-CLI automation
- ✅ **DevOps practices** - Infrastructure as Code, automation
- ✅ **Network architecture** - Container communication
- ✅ **Security hardening** - Secrets, TLS, isolation

## 🐛 Troubleshooting

### Common Issues

**Domain not resolving:**
- Check that `/etc/hosts` contains the correct entry
- Verify the domain matches your login: `yourlogin.42.fr`

**Containers not starting:**
```bash
# Check container status
docker compose -f srcs/docker-compose.yml ps

# View error logs
docker compose -f srcs/docker-compose.yml logs
```

**Permission denied errors:**
- Ensure secrets files have correct permissions
- Make sure Docker daemon is running: `sudo systemctl status docker`

**Port 443 already in use:**
```bash
# Find what's using port 443
sudo lsof -i :443

# Stop the conflicting service or change the port mapping
```

## 📖 Resources

### Documentation

- Docker — https://docs.docker.com/
- Docker Compose — https://docs.docker.com/compose/
- WordPress Developer Docs — https://developer.wordpress.org/
- Nginx Documentation — https://nginx.org/en/docs/
- MariaDB Documentation — https://mariadb.com/docs/
- WP-CLI — https://wp-cli.org/

### For more details

- Developer documentation: DEV_DOC.md
- User documentation: USER_DOC.md

## 👥 Author

**Clothilde Scache** (cscache)
- GitHub: [@clothildesc](https://github.com/clothildesc)

## 📄 License

This project is part of the 42 School curriculum.

---

*Built with 🐳 at 42 School*