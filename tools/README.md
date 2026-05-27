# Caddy

## CloudFlare setup

- Create `A` (IPv4) and `AAAA` (IPv6) records for every subdomain.
- Create an API Token with `Zone.Zone` and `Zone.DNS` permissions - required for Let's Encrypt certificate
- In caddyfile define the TLS section to use cloudflare's API Token

```
example.com {
    tls {
        dns cloudflare {$CLOUDFLARE_API_TOKEN}
    }
    
    reverse_proxy your_app_container:8080
}
```

> NOTE: the `tls` section can be removed after the certificate gets created

## Reload configuration

`docker exec -w /etc/caddy caddy caddy reload`

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

## Formatting

Run this command `caddy fmt --overwrite` in the directory with the `Caddyfile`