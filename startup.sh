#!/bin/bash

# Startup script to initialize all services and verify they're working

set -e

echo "🚀 Starting Web Development Lab Environment..."
echo ""

# Build and start services
echo "📦 Building and starting containers..."
docker compose build --quiet 2>&1 | grep -v "DEPRECATED"
docker compose up -d

echo "✓ Containers started"
echo ""

echo "⏳ Waiting for services to be ready (this may take 60-90 seconds)..."
echo ""

# Wait for key services to be healthy
echo "  Waiting for MySQL..."
for i in {1..60}; do
  if docker compose exec -T mysql_db mysqladmin ping -h 127.0.0.1 -uroot -prootpass --silent 2>/dev/null; then
    echo "  ✓ MySQL is ready"
    break
  fi
  sleep 1
done

echo "  Waiting for PostgreSQL..."
for i in {1..60}; do
  if docker compose exec -T postgres pg_isready -U postgres_user 2>/dev/null | grep -q "accepting"; then
    echo "  ✓ PostgreSQL is ready"
    break
  fi
  sleep 1
done

echo "  Waiting for MongoDB..."
for i in {1..60}; do
  if docker compose exec -T mongodb mongosh --username root --password rootpass --eval "db.adminCommand('ping')" 2>/dev/null | grep -q '"ok" : 1'; then
    echo "  ✓ MongoDB is ready"
    break
  fi
  sleep 1
done

echo ""
echo "📥 Installing frontend dependencies..."
docker compose exec -T frontend npm install > /dev/null 2>&1 || true
echo "✓ Dependencies installed"

echo ""
echo "✅ All services are starting up!"
echo ""
echo "📚 Available URLs:"
echo "   🌐 Web Server (PHP):     http://localhost:8080"
echo "   📊 phpMyAdmin (MySQL):   http://localhost:8081"
echo "   🗄️  pgAdmin (PostgreSQL): http://localhost:5050"
echo "   🌿 MongoDB Express:      http://localhost:8082"
echo "   📧 MailHog:              http://localhost:8025"
echo "   ⚛️  React Frontend:       http://localhost:5173"
echo ""
echo "💡 Tips:"
echo "   • View logs:       docker compose logs -f [service-name]"
echo "   • Run shell:       docker compose exec [service] bash"
echo "   • Stop services:   docker compose down"
echo ""
echo "🏃 Run health check:"
echo "   bash health-check.sh"
echo ""
