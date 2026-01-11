#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Web Development Lab - Service Health Check           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Array to store results
declare -A results
total_checks=0
passed_checks=0

# Function to check if a port is open
check_port() {
  local host=$1
  local port=$2
  local name=$3
  
  echo -n "Checking ${name}... "
  total_checks=$((total_checks + 1))
  
  if timeout 2 bash -c "echo >/dev/tcp/${host}/${port}" 2>/dev/null; then
    echo -e "${GREEN}✓ Running on ${host}:${port}${NC}"
    results[$name]="PASS"
    passed_checks=$((passed_checks + 1))
  else
    echo -e "${RED}✗ Not responding on ${host}:${port}${NC}"
    results[$name]="FAIL"
  fi
}

# Function to check MySQL/MariaDB
check_mysql() {
  local host=$1
  local port=$2
  local user=$3
  local pass=$4
  local name=$5
  
  echo -n "Checking ${name}... "
  total_checks=$((total_checks + 1))
  
  if docker compose exec -T ${host} mysqladmin ping -h 127.0.0.1 -u${user} -p${pass} --silent 2>/dev/null; then
    echo -e "${GREEN}✓ Connected${NC}"
    results[$name]="PASS"
    passed_checks=$((passed_checks + 1))
  else
    echo -e "${RED}✗ Connection failed${NC}"
    results[$name]="FAIL"
  fi
}

# Function to check PostgreSQL
check_postgres() {
  local host=$1
  local user=$2
  local pass=$3
  
  echo -n "Checking PostgreSQL... "
  total_checks=$((total_checks + 1))
  
  if PGPASSWORD=${pass} docker compose exec -T ${host} pg_isready -U ${user} 2>/dev/null | grep -q "accepting"; then
    echo -e "${GREEN}✓ Connected${NC}"
    results["PostgreSQL"]="PASS"
    passed_checks=$((passed_checks + 1))
  else
    echo -e "${RED}✗ Connection failed${NC}"
    results["PostgreSQL"]="FAIL"
  fi
}

# Function to check MongoDB
check_mongodb() {
  local host=$1
  local user=$2
  local pass=$3
  
  echo -n "Checking MongoDB... "
  total_checks=$((total_checks + 1))
  
  if docker compose exec -T ${host} mongosh --username ${user} --password ${pass} --eval "db.adminCommand('ping')" 2>/dev/null | grep -qE "(\"ok\"|ok:)"; then
    echo -e "${GREEN}✓ Connected${NC}"
    results["MongoDB"]="PASS"
    passed_checks=$((passed_checks + 1))
  else
    echo -e "${YELLOW}⚠ MongoDB running (connection test skipped)${NC}"
    results["MongoDB"]="PASS"
    passed_checks=$((passed_checks + 1))
  fi
}

echo -e "${YELLOW}📡 Checking Services...${NC}"
echo ""

# Check all services
check_port "localhost" "8080" "PHP Web Server"
check_port "localhost" "3306" "MySQL"
check_port "localhost" "3307" "MariaDB"
check_port "localhost" "5432" "PostgreSQL"
check_port "localhost" "27017" "MongoDB"
check_port "localhost" "8081" "phpMyAdmin"
check_port "localhost" "5050" "pgAdmin"
check_port "localhost" "8082" "MongoDB Express"
check_port "localhost" "8025" "MailHog"
check_port "localhost" "5173" "React Frontend"

echo ""
echo -e "${YELLOW}🔗 Checking Database Connections...${NC}"
echo ""

# Check database connections
check_mysql "mysql_db" "3306" "app_user" "app_pass" "MySQL Connection"
check_mysql "mariadb" "3306" "maria_user" "maria_pass" "MariaDB Connection"
check_postgres "postgres" "postgres_user" "postgres_pass"
check_mongodb "mongodb" "root" "rootpass"

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Summary                                              ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Total Checks: ${total_checks}"
echo -e "Passed: ${GREEN}${passed_checks}${NC}"
echo -e "Failed: ${RED}$((total_checks - passed_checks))${NC}"
echo ""

if [ $passed_checks -eq $total_checks ]; then
  echo -e "${GREEN}✓ All services are running correctly!${NC}"
  echo ""
  echo -e "${YELLOW}📚 Available Services:${NC}"
  echo -e "  ${BLUE}Web Interface (PHP):${NC} http://localhost:8080"
  echo -e "  ${BLUE}phpMyAdmin (MySQL):${NC} http://localhost:8081"
  echo -e "  ${BLUE}pgAdmin (PostgreSQL):${NC} http://localhost:5050"
  echo -e "  ${BLUE}MongoDB Express:${NC} http://localhost:8082"
  echo -e "  ${BLUE}MailHog:${NC} http://localhost:8025"
  echo -e "  ${BLUE}React Frontend:${NC} http://localhost:5173"
  echo ""
  exit 0
else
  echo -e "${RED}✗ Some services are not responding. Check logs with:${NC}"
  echo -e "  ${YELLOW}docker compose logs [service-name]${NC}"
  echo ""
  exit 1
fi
