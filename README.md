# 🚀 Web Development Lab - Complete Environment

A comprehensive Docker-based development environment for learning full-stack web development with PHP, Python, JavaScript/React, and multiple databases.

## 📋 Overview

This environment provides students with everything needed for modern web development:

### 🌐 **Frontend**
- **React 18** with TypeScript
- **Vite** for ultra-fast development
- **Bootstrap** & modern CSS styling
- Running on **http://localhost:5173**

### 🔧 **Backend**
- **PHP 8.2** with Apache 2.4
- **Composer** for package management
- **Xdebug** for debugging
- **PDO** & **mysqli** extensions
- Running on **http://localhost:8080**

### 💾 **Databases**
| Database | Port | Username | Password | GUI |
|----------|------|----------|----------|-----|
| **MySQL 8.0** | 3306 | app_user | app_pass | phpMyAdmin (8081) |
| **MariaDB 10.11** | 3307 | maria_user | maria_pass | phpMyAdmin (8081) |
| **PostgreSQL 15** | 5432 | postgres_user | postgres_pass | pgAdmin (5050) |
| **MongoDB 6.0** | 27017 | root | rootpass | MongoDB Express (8082) |
| **Redis 7** | 6379 | - | - | - |
| **Meilisearch** | 7700 | - | masterKey | - |
| **MinIO (S3)** | 9000/9001 | minio_user | minio_pass | Console (9001) |

### 🛠️ **Development Tools**
- **phpMyAdmin** - MySQL/MariaDB GUI (http://localhost:8081)
- **pgAdmin** - PostgreSQL Management (http://localhost:5050)
- **MongoDB Express** - MongoDB Web GUI (http://localhost:8082)
- **MailHog** - Email testing tool (http://localhost:8025)
- **Dozzle** - Real-time Log Viewer (http://localhost:8888)
- **MinIO Console** - S3 Browser (http://localhost:9001)
- **Node.js 18** - For npm/yarn commands
- **npm/yarn** - Package managers

---

## ⚠️ Prerequisites & Platform Setup

### **All Platforms: Docker Desktop Required**
Install [Docker Desktop](https://www.docker.com/products/docker-desktop) for your operating system:
- **Windows**: https://docs.docker.com/desktop/install/windows-install/
- **macOS**: https://docs.docker.com/desktop/install/mac-install/
- **Linux**: https://docs.docker.com/engine/install/

---

### **🪟 Windows: WSL 2 is CRITICAL**

This project **REQUIRES WSL 2** (Windows Subsystem for Linux 2) on Windows. Without it, the React frontend will fail with `vite: not found` errors.

#### **Why WSL 2?**
- Windows NTFS handles symlinks differently than Linux
- npm creates symlinks in `node_modules/.bin/` for executables
- These symlinks fail on Windows NTFS without WSL 2
- WSL 2 provides native Linux filesystem which works correctly

#### **Step 1: Install WSL 2**
```powershell
# Run PowerShell as Administrator
wsl --install -d Ubuntu
wsl --update
wsl --set-default-version 2
```

**Verify WSL 2 is installed:**
```powershell
wsl -l -v
# Should show Ubuntu with VERSION 2
```

#### **Step 2: Enable Docker Desktop WSL 2 Backend**
1. Open **Docker Desktop**
2. Go to **Settings** → **General**
3. ✅ Enable **"Use the WSL 2 based engine"**
4. Go to **Settings** → **Resources** → **WSL Integration**
5. ✅ Check your Ubuntu distribution
6. Click **Apply & Restart**

**Verify Docker is using Linux:**
```powershell
docker info | findstr "OSType"
# Should show: OSType: linux
```

#### **Step 3: Clone and Run from WSL 2**
```bash
# Open Ubuntu terminal or WSL tab in VSCode
wsl
cd ~
git clone https://github.com/MustafaDaraghmeh/lamp-docker.git
cd lamp-docker
bash startup.sh
```

⚠️ **Important:** Always use **WSL 2 Ubuntu terminal** for Docker commands, not PowerShell/CMD

---

### **🍎 macOS: Additional Configuration**

macOS works well with Docker Desktop, but consider these optimizations:

#### **Docker Desktop Settings for macOS**
1. **Settings** → **Resources** → **Memory**: Allocate at least **4GB** (8GB recommended)
2. **Settings** → **Resources** → **CPUs**: Allocate at least **2 CPUs** (4+ recommended)
3. **Settings** → **File Sharing**: Ensure your project directory is shared

#### **Performance Tips for macOS**
```bash
# Use delegated mounts for better performance
# (Already configured in docker-compose.yml)

# If you experience slow file syncing:
docker volume prune  # Clean unused volumes
docker system prune  # Clean system resources
```

#### **M1/M2 Mac Compatibility**
If you have an M1 or M2 Mac (Apple Silicon):
- Docker Desktop works natively (no issues)
- Verify you have the ARM64 version of Docker Desktop
- All services run without additional configuration

---

### **🐧 Linux (Ubuntu/Debian): Native Docker**

Linux has native Docker support with no additional setup needed:
```bash
# Install Docker
sudo apt-get update
sudo apt-get install docker.io docker-compose

# Add your user to docker group (optional)
sudo usermod -aG docker $USER
newgrp docker
```

---

## 🚀 Quick Start

### 1. **Start All Services**
```bash
bash startup.sh
```

This script will:
- Build all Docker images
- Start all containers
- Wait for services to become healthy
- Install frontend dependencies
- Display all available URLs

### 2. **Manual Start (Alternative)**
```bash
docker compose build
docker compose up -d
```

### 3. **Verify Everything is Running**
```bash
bash health-check.sh
```

This will test all services and databases, showing you which ones are responding correctly.

---

## 📍 Service URLs & Credentials

### **Web Servers**
```
🌐 PHP/Apache:       http://localhost:8080
⚛️  React Frontend:    http://localhost:5173
📊 Dashboard (HTML):   http://localhost:8080/dashboard.html
```

### **Database Management UIs**
```
📋 phpMyAdmin:        http://localhost:8081
   User: app_user, Password: app_pass

🗄️  pgAdmin:          http://localhost:5050
   Email: admin@example.com, Password: admin

🌿 MongoDB Express:   http://localhost:8082
   Username: root, Password: rootpass

📧 MailHog:           http://localhost:8025
```

### **Database Connection Strings**

#### MySQL (Port 3306)
```php
$pdo = new PDO(
  "mysql:host=mysql_db;dbname=app_db;charset=utf8mb4",
  "app_user",
  "app_pass"
);
```

#### MariaDB (Port 3307)
```php
$pdo = new PDO(
  "mysql:host=mariadb;dbname=mariadb_db;charset=utf8mb4",
  "maria_user",
  "maria_pass"
);
```

#### PostgreSQL (Port 5432)
```php
$pdo = new PDO(
  "pgsql:host=postgres;port=5432;dbname=postgres_db",
  "postgres_user",
  "postgres_pass"
);
```

#### MongoDB (Port 27017)
```javascript
const uri = "mongodb://root:rootpass@localhost:27017/app_db";
const client = new MongoClient(uri);
```

---

## 📁 Project Structure

```
lamp-docker/
├── docker/                    # Docker build configurations
│   └── web/
│       └── Dockerfile        # PHP 8.2 + Apache build
├── www/                       # PHP web root
│   ├── index.php             # PHP dashboard
│   └── dashboard.html        # HTML service dashboard
├── frontend/                  # React + TypeScript project
│   ├── src/
│   │   ├── App.tsx           # React component
│   │   ├── App.css           # Styles
│   │   ├── main.tsx          # React entry point
│   │   └── index.css         # Global styles
│   ├── package.json          # Node dependencies
│   ├── vite.config.ts        # Vite configuration
│   ├── tsconfig.json         # TypeScript config
│   └── index.html            # React HTML template
├── db/                        # Database initialization
│   └── init/
│       ├── 01_schema_01.sql  # Your SQL files here
│       └── 01_schema_02.sql  # Executed on first startup
├── docker-compose.yml         # All service definitions
├── .env                       # Environment variables
├── startup.sh                 # Quick start script
├── health-check.sh           # Service verification script
└── README.md                  # This file
```

---

## ⚙️ Configuration

### **Environment Variables (.env)**
Modify `.env` to change default passwords and settings:

```bash
# MySQL
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=app_db
MYSQL_USER=app_user
MYSQL_PASSWORD=app_pass

# MariaDB
MARIADB_ROOT_PASSWORD=rootpass
MARIADB_DATABASE=mariadb_db
MARIADB_USER=maria_user
MARIADB_PASSWORD=maria_pass

# PostgreSQL
POSTGRES_ROOT_PASSWORD=rootpass
POSTGRES_DB=postgres_db
POSTGRES_USER=postgres_user
POSTGRES_PASSWORD=postgres_pass

# MongoDB
MONGO_ROOT_USER=root
MONGO_ROOT_PASSWORD=rootpass
MONGO_INITDB_DATABASE=app_db
```

---

## 🐳 Common Docker Commands

### **View Service Status**
```bash
docker compose ps
```

### **View Service Logs**
```bash
# All services
docker compose logs -f

# Specific service
docker compose logs -f [service-name]

# Example services
docker compose logs -f web          # PHP/Apache logs
docker compose logs -f frontend     # React dev server logs
docker compose logs -f mysql_db     # MySQL logs
```

### **Execute Commands in Containers**

#### PHP/Composer Commands
```bash
# Access PHP container shell
docker compose exec workspace bash

# Run composer
docker compose exec workspace composer install

# Run PHP directly
docker compose exec workspace php -v
```

#### Node/npm Commands
```bash
# Access Node container shell
docker compose exec frontend bash

# Install npm packages
docker compose exec frontend npm install

# Run npm scripts
docker compose exec frontend npm run build
```

#### Database Commands
```bash
# MySQL CLI
docker compose exec mysql_db mysql -uapp_user -papp_pass app_db

# PostgreSQL CLI
docker compose exec postgres psql -U postgres_user -d postgres_db

# MongoDB CLI
docker compose exec mongodb mongosh -u root -p rootpass
```

### **Restart Services**
```bash
# Restart all services
docker compose restart

# Restart specific service
docker compose restart web

# Rebuild and restart
docker compose up -d --build
```

### **Stop Services**
```bash
# Stop without removing
docker compose stop

# Stop and remove containers (data persists in volumes)
docker compose down

# Remove everything including volumes
docker compose down -v
```

---

## 🧪 Testing Your Setup

### **1. Test PHP Backend**
Visit http://localhost:8080 to see:
- PHP version information
- Available database connections
- List of enabled extensions
- Quick access to all services

### **2. Test React Frontend**
Visit http://localhost:5173 to see:
- Service status dashboard
- Database connection info
- Technology stack overview
- Real-time service monitoring

### **3. Test MySQL/MariaDB**
```bash
# Access phpMyAdmin
http://localhost:8081

# Or test via PHP
docker compose exec workspace php -c "PDO with your credentials"
```

### **4. Test PostgreSQL**
```bash
# Access pgAdmin
http://localhost:5050

# Or test via CLI
docker compose exec postgres psql -U postgres_user -d postgres_db
```

### **5. Test MongoDB**
```bash
# Access MongoDB Express
http://localhost:8082

# Or test via CLI
docker compose exec mongodb mongosh -u root -p rootpass
```

### **6. Run Health Check**
```bash
bash health-check.sh
```

---

## 🎯 Development Workflow Examples

### **Creating a PHP API**
```bash
# 1. Create API file in www/
echo '<?php echo json_encode(["status" => "ok"]); ?>' > www/api.php

# 2. Access it
curl http://localhost:8080/api.php

# 3. Connect to database in PHP
# Use connection strings from Database Connection section above
```

### **Building a React Component**
```bash
# 1. Edit frontend/src/App.tsx
docker compose exec frontend bash
npm run dev

# 2. Visit http://localhost:5173
# Hot reload enabled - changes reflect instantly
```

### **Initializing Databases**
```bash
# 1. Add SQL files to db/init/
# Files are executed automatically on first startup
# Format: 01_*.sql, 02_*.sql, etc. (numbered order)

# 2. Add MongoDB initialization
# Use MongoDB Express GUI or mongosh CLI
```

### **Installing PHP Packages**
```bash
docker compose exec workspace composer require symfony/http-foundation
```

### **Installing Node Packages**
```bash
docker compose exec frontend npm install axios react-router-dom
```

---

## 🔧 Customization

### **Add New PHP Extensions**
Edit `docker/web/Dockerfile`:
```dockerfile
RUN docker-php-ext-install [extension-name]
```

Then rebuild:
```bash
docker compose up -d --build
```

### **Change Database Ports**
Edit `docker-compose.yml` ports section:
```yaml
services:
  mysql_db:
    ports:
      - "3306:3306"  # Change left number to use different host port
```

### **Enable Xdebug in IDE**
Your IDE should connect to:
- **Host**: `localhost` or `127.0.0.1`
- **Port**: `9003`
- **Path mapping**: `/var/www/html` → `./www`

### **Configure React Development**
Edit `frontend/vite.config.ts` for custom settings.

---

## ⚠️ Troubleshooting

### **Services Not Starting**
```bash
# Check logs
docker compose logs -f

# Try rebuilding
docker compose down
docker compose build --no-cache
docker compose up -d
```

### **Database Connection Fails**
```bash
# Check if service is healthy
docker compose ps

# Wait longer for startup
docker compose logs mysql_db  # Look for "ready for connections"

# Test connection directly
docker compose exec mysql_db mysql -uroot -prootpass -e "SELECT 1;"
```

### **Port Already in Use**
Change ports in `.env` or `docker-compose.yml`:
```yaml
ports:
  - "8085:80"  # Change 8085 to any free port
```

### **React Frontend Not Compiling**
```bash
# Clear node_modules and reinstall
docker compose exec frontend rm -rf node_modules package-lock.json
docker compose exec frontend npm install
```

### **🪟 Windows: Frontend (Vite) Errors**

**Error:** `/app/node_modules/.bin/vite: line 1: not found` or similar

**Solution: Verify WSL 2 Setup**
1. Confirm WSL 2 is installed and set as default:
   ```powershell
   wsl -l -v
   # Should show: Ubuntu ... 2
   ```

2. Verify Docker uses WSL 2 backend:
   ```powershell
   docker info | findstr "OSType"
   # Should show: OSType: linux
   ```

3. Clone repo INSIDE WSL 2 home directory:
   ```bash
   wsl
   cd ~
   git clone https://github.com/MustafaDaraghmeh/lamp-docker.git
   cd lamp-docker
   bash startup.sh
   ```

4. Always use **WSL 2 Ubuntu terminal**, not PowerShell/CMD

5. If error persists, clean rebuild:
   ```bash
   docker compose down -v
   rm -rf frontend/node_modules frontend/package-lock.json
   docker compose up -d --build
   ```

**Why this happens:** Windows NTFS symlinks don't work the same as Linux. WSL 2 provides native Linux filesystem support.

### **Out of Disk Space**
```bash
# Clean up unused Docker resources
docker system prune -a --volumes
```

---

## 📚 Learning Resources

### **PHP & Databases**
- Test queries in phpMyAdmin or pgAdmin GUIs
- Use `docker compose exec workspace bash` for CLI access
- Check Xdebug with your IDE

### **React & TypeScript**
- Hot reload at http://localhost:5173
- Edit files in `frontend/src/`
- Use browser DevTools for debugging

### **Docker**
- Learn container architecture with `docker compose ps`
- Understand networking with service names (e.g., `mysql_db:3306`)
- Explore volumes with `docker volume ls`

---

## 🆘 Support & Debugging

### **Enable Debug Logging**
```bash
# See all service output
docker compose up -d --force-recreate

# Watch logs in real-time
docker compose logs -f
```

### **Access Container Shells**
```bash
# PHP/Backend
docker compose exec workspace bash

# Node/Frontend
docker compose exec frontend bash

# Database tools
docker compose exec mysql_db bash
docker compose exec postgres bash
docker compose exec mongodb bash
```

### **Health Check Details**
```bash
# Full health check with detailed output
bash health-check.sh

# or
bash -x health-check.sh  # With debug output
```

---

## 📝 Notes

- **Data Persistence**: Database data is stored in Docker volumes (`mysql_data`, `postgres_data`, etc.)
- **Network**: Services communicate via container names (e.g., `mysql_db`, `postgres`)
- **File Sharing**: `www/` and `frontend/` directories are live-synced with containers
- **Email Testing**: All emails go to MailHog (http://localhost:8025)
- **Performance**: Use `delegated` volumes for better Mac/Windows performance

---

## 📄 License

Educational use for web development courses. Modify freely for your needs.

---

**Happy coding! 🎉**

For issues or improvements, update the configuration files and restart with `docker compose up -d --build`.
