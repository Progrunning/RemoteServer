#!/bin/bash

# Caddy Password Hash Generator
# Usage: ./generate-passwords.sh

echo "=== Caddy Password Hash Generator ==="
echo ""
echo "This script generates bcrypt password hashes for Caddy basic auth."
echo ""

# Check if caddy is available
if ! command -v caddy &> /dev/null; then
    echo "❌ Caddy is not installed locally."
    echo ""
    echo "Two options:"
    echo ""
    echo "Option 1: Generate hashes from a running Caddy container:"
    echo "  cd /home/miko/dev/tools"
    echo "  docker-compose up -d caddy"
    echo "  docker exec caddy caddy hash-password -plaintext 'YOUR_PASSWORD_HERE'"
    echo ""
    echo "Option 2: Use an online tool at:"
    echo "  https://bcrypt.online/"
    echo "  (But for security, prefer Option 1)"
    exit 1
fi

echo "Enter passwords and I'll generate bcrypt hashes for you."
echo ""

# Generate Grafana password hash
read -sp "Grafana admin password: " GRAFANA_PASS
echo ""
GRAFANA_HASH=$(caddy hash-password -plaintext "$GRAFANA_PASS")

# Generate Beszel password hash
read -sp "Beszel admin password: " BESZEL_PASS
echo ""
BESZEL_HASH=$(caddy hash-password -plaintext "$BESZEL_PASS")

# Generate Caddy admin password hash
read -sp "Caddy admin API password: " CADDY_ADMIN_PASS
echo ""
CADDY_ADMIN_HASH=$(caddy hash-password -plaintext "$CADDY_ADMIN_PASS")

echo ""
echo "=== Generated Hashes (copy to .env file) ==="
echo ""
echo "GRAFANA_PASSWORD_HASH=$GRAFANA_HASH"
echo "BESZEL_PASSWORD_HASH=$BESZEL_HASH"
echo "CADDY_ADMIN_PASSWORD_HASH=$CADDY_ADMIN_HASH"
echo ""
