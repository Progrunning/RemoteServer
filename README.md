# Docker user

Docker containers run as `root` by default, this is a security risk and should be mitigated by running them in a context of less privilaged user (e.g. 1001).

Do this be defining `user: "${UID:-1001}:${GID:-1001}"` in the service's docker compose configuration.

# Docker volumes setup

Recommendation is to use `/srv/docker` as the main path for mounting volumens for docker compose running services. Each service should have its own directory (e.g. `/srv/docker/arcane`), where all of the relevant files will be persisted.

`/srv/docker/` directory is and should stay `root` owned. However, the subdirectories should be

1. Created prior to docker deployment (e.g. `sudo mkdir /srv/docker/arcane`)
2. Ownership should be updated to the docker's user (e.g. `sudo chown -R 1001:1001 /srv/docker/arcane`)
3. Permissions for other users and groups should be removed. Docker user should have `rwx` -> 700 permissions (e.g. `sudo chmod 700 /srv/docker/arcane`)