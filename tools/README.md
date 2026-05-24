# Caddy

## Install

`brew install caddy` - installs CLI

## Auth

Caddy provides a way to protect subdomains with basic auth. However, instead of providing the user and password in the config (/conf/Caddyfile) it requires a bcrypt hashed version of the password. Below how it works:

Your Actual Password: "MySecurePassword123"
                          ↓ (run through caddy hash-password)
Stored Hash in .env: "$2a$14$abcdef123..."
                          ↓ (user visits https://grafana.progrunning.net)
User enters password: "MySecurePassword123"
                          ↓ (Caddy compares hash)
Caddy verifies it matches ✅

To generate password, run the `generate-password.sh` script