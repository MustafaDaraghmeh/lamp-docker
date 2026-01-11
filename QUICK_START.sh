#!/usr/bin/env bash

# Quick Start Guide for Web Development Lab

cat << 'EOF'

╔════════════════════════════════════════════════════════════════════════════╗
║                                                                            ║
║         🚀 WEB DEVELOPMENT LAB - QUICK START GUIDE                        ║
║                                                                            ║
║                    For Students & Educators                               ║
║                                                                            ║
╚════════════════════════════════════════════════════════════════════════════╝

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 1: INITIAL SETUP (One-time)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Install Requirements:
    • Docker Desktop (https://www.docker.com/products/docker-desktop)
    • Docker Compose (included with Docker Desktop)
    • Git (optional, for version control)

  Clone or Download:
    This project should be in: /root/lamp-docker/

  Navigate to Project:
    cd /root/lamp-docker


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 2: START THE ENVIRONMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  FASTEST WAY (Recommended):
    bash startup.sh

  MANUAL WAY (If you prefer):
    docker compose build
    docker compose up -d

  WAIT... (Services take 30-60 seconds to fully start)


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 3: VERIFY EVERYTHING IS RUNNING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Run Health Check:
    bash health-check.sh

  Expected Output:
    ✓ All services running correctly!

  View Status:
    docker compose ps


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STEP 4: OPEN IN YOUR BROWSER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  🌐 Main Services:
    • Web Server (PHP):         http://localhost:8080
    • React Frontend:           http://localhost:5173
    • Service Dashboard (HTML): http://localhost:8080/dashboard.html

  📊 Database Management:
    • phpMyAdmin (MySQL):       http://localhost:8081
    • pgAdmin (PostgreSQL):     http://localhost:5050
    • MongoDB Express:          http://localhost:8082
    • MailHog (Email):          http://localhost:8025


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DATABASES - CONNECTION INFO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  MySQL:           Host: mysql_db     Port: 3306    User: app_user
  MariaDB:         Host: mariadb      Port: 3306    User: maria_user
  PostgreSQL:      Host: postgres     Port: 5432    User: postgres_user
  MongoDB:         Host: mongodb      Port: 27017   User: root

  (Passwords configured in .env file)


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WORKING WITH CODE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  📝 Create PHP Files:
    • Edit files in: www/
    • Access at: http://localhost:8080/yourfile.php
    • Auto-reloads on save

  ⚛️  Create React Components:
    • Edit files in: frontend/src/
    • Auto-compiles and hot-reloads
    • Visit: http://localhost:5173

  🗄️  Initialize Databases:
    • Add SQL files to: db/init/
    • Files run automatically on first startup
    • Example: db/init/01_schema_01.sql


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMMON COMMANDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Container Management:
    docker compose ps               # Show running containers
    docker compose logs -f          # View all logs (live)
    docker compose logs -f web      # View specific service logs
    docker compose down             # Stop all services
    docker compose restart          # Restart all services

  PHP/Backend Commands:
    docker compose exec workspace bash          # Open PHP shell
    docker compose exec workspace composer install  # Install packages
    docker compose exec workspace php -v        # Check PHP version

  Frontend/Node Commands:
    docker compose exec frontend bash           # Open Node shell
    docker compose exec frontend npm install    # Install npm packages
    docker compose exec frontend npm run build  # Build React

  Database Commands:
    docker compose exec mysql_db mysql -uapp_user -papp_pass app_db
    docker compose exec postgres psql -U postgres_user postgres_db
    docker compose exec mongodb mongosh -u root -p rootpass


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TROUBLESHOOTING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Problem: Port already in use
    Solution: Edit docker-compose.yml to change ports, e.g. "8085:80"

  Problem: Services not responding
    Solution: docker compose logs -f
             (Look for error messages)

  Problem: Database connection fails
    Solution: 1. Wait 60 seconds after startup
              2. Run: bash health-check.sh
              3. Check service is running: docker compose ps

  Problem: Out of disk space
    Solution: docker system prune -a --volumes

  Problem: Changes not appearing
    Solution: 1. Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
              2. For Docker: docker compose restart


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DOCUMENTATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Full Documentation:    README.md
  Services Overview:     SERVICES.txt
  This Guide:            QUICK_START.sh

  View Services List:
    cat SERVICES.txt

  View Full README:
    cat README.md


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WHAT'S INCLUDED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Backend:
    ✓ PHP 8.2 with Apache
    ✓ Composer package manager
    ✓ Xdebug for debugging
    ✓ PDO, mysqli, zip extensions

  Frontend:
    ✓ React 18 with TypeScript
    ✓ Vite (ultra-fast build tool)
    ✓ Hot Module Reloading (HMR)
    ✓ Bootstrap & modern CSS

  Databases:
    ✓ MySQL 8.0
    ✓ MariaDB 10.11 (MySQL alternative)
    ✓ PostgreSQL 15
    ✓ MongoDB 6.0 (NoSQL)

  Tools:
    ✓ phpMyAdmin - MySQL GUI
    ✓ pgAdmin - PostgreSQL GUI
    ✓ MongoDB Express - MongoDB GUI
    ✓ MailHog - Email testing
    ✓ Node.js 18 - JavaScript runtime


━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GETTING HELP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  View Logs:
    docker compose logs -f [service-name]

  Service Names:
    web, workspace, frontend, node, mysql_db, mariadb,
    postgres, mongodb, phpmyadmin, pgadmin, mongo_express, mailhog

  Example:
    docker compose logs -f web        # See PHP/Apache logs
    docker compose logs -f frontend   # See React logs
    docker compose logs -f mysql_db   # See MySQL logs


╔════════════════════════════════════════════════════════════════════════════╗
║                                                                            ║
║               Ready to start learning web development! 🎓                 ║
║                                                                            ║
║              Questions? Check README.md for detailed info                 ║
║                                                                            ║
╚════════════════════════════════════════════════════════════════════════════╝

EOF
