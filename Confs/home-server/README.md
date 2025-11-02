# 🧰 Self-Hosted Nextcloud Stack (with Nginx and PostgreSQL)

This project sets up a **self-hosted Nextcloud instance**.  
It uses **Docker Compose** to orchestrate four main services:

- `Nextcloud` (PHP-FPM app)
- `PostgreSQL` (database)
- `Nginx` (web server & reverse proxy)

All credentials and environment-specific details are stored securely in a `.env` file.

---

## 📦 Containers Overview

### 1. `cloud` — Main Nextcloud Application
- **Image:** `nextcloud:fpm`
- **Purpose:** Runs the Nextcloud PHP backend (without a web server, only PHP-FPM).  
- **Depends on:** `db`

This container handles file syncing, user management, plugins, and APIs — essentially, the full Nextcloud platform logic.

---

### 2. `db` — PostgreSQL Database
- **Image:** `postgres:16`
- **Purpose:** Persistent storage of Nextcloud metadata (users, file indices, settings, etc.).

Make sure the `/srv/nextcloud/db` directory has correct permissions (`chown 999:999`).

---

### 3. `nginx` — Web Server & Reverse Proxy
- **Image:** `nginx:latest`
- **Purpose:**  
  Serves the Nextcloud web interface over HTTPS and forwards PHP requests to the `nextcloud-app` (via FastCGI).  
  Also exposes port `80` for Let’s Encrypt challenges and HTTP → HTTPS redirects.

**Ports:**
- `80` → HTTP (used for initial certbot validation)
- `443` → HTTPS (secure access to Nextcloud)
