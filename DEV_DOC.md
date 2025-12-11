# Developer Documentation — Inception

This document explains how to set up, build, run, and manage the Inception project from a developer perspective.

---

## 1. Environment Setup From Scratch

### **Prerequisites**
Before starting, ensure the following tools are installed:

- Docker
- Docker Compose (v2+)
- Make
- GNU sed, curl, openssl (usually already present on Linux/macOS)

### **Project Structure**

inception/
│
├── Makefile
├── secrets/
│ ├── db_password.txt
│ ├── db_root_password.txt
│ ├── wp_admin_password.txt
│ └── wp_user_password.txt
│
├── srcs/
│ ├── .env
│ ├── docker-compose.yml
│ ├── requirements/
│   ├── mariadb/
│   ├── wordpress/
│   └── nginx/
└── …