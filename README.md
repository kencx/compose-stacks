# Compose Stacks

This is a repository of `docker-compose.yaml` files for various self-hosted applications.
They include:
- Traefik + [Socket Proxy](https://github.com/Tecnativa/docker-socket-proxy)
- Authelia
- Portainer
- Syncthing
- Photoprism
- Paperless-Ngx
- Linkding
- Miniflux
- Calibre-Web
- Calibre
- Firefly III
- Pihole
- Gitea
- Drone CI
- Nginx Proxy Manager
- Actual
- Uptime-Kuma
- Registry
- pgadmin

## Usage

### Docker network
Most of the services use Traefik as a reverse proxy. This requires
the creation of an external docker network **prior** to starting any containers.

AFAIK, there is no easy way of creating an external network
[programmatically](https://github.com/docker/compose/issues/2846), nor are
[pre-hook](https://github.com/docker/compose/issues/1341) scripts supported.
As such, we need to manually create the networks:

```bash
$ docker network create proxy          # for traefik
$ docker network create socket-proxy   # for socket-proxy
```

The network name `proxy` and `socket-proxy` is used in all compose files. If you
wish to change it, ensure all occurrences are replaced manually. Sadly, this cannot
be configured with `.env` as environment variables cannot be passed into yaml keys.
