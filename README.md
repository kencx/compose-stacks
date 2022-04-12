# Compose Stacks

This is a repository of my `docker-compose.yaml` files for various self-hosted applications.
They include:
- Traefik + [Socket Proxy](https://github.com/Tecnativa/docker-socket-proxy)
- Authelia
- Portainer
- Syncthing
- Photoprism
- Paperless-Ng
- Linkding
- Miniflux
- Calibre-Web
- Firefly III
- Pihole
- Gitea
- Drone CI
- Nginx Proxy Manager (deprecated)
- and an extra Borgmatic configuration (not run in docker)

## TODO
- [ ] Secrets management with SOPS
- [ ] Overrides compose files for different env

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
wish to change it, ensure all occurences are replaced manually. Sadly, this cannot 
be configured with `.env` as environment variables cannot be passed into yaml keys.

### Environment Variables
Copy `.env` from `.env.example` in the base directory. This is the global
configuration file for all containers.

```bash
$ cp .env.example .env
```

Each sub-directory contains a base `docker-compose.yml` file and a relevant
`[service].env` file for *container-specific* configuration.

Change the env vars in each `[service].env` to your liking. Refer to each service's
documentation for more details.

### Docker-Compose Commands
There are 3 custom commands for executing docker-compose actions:
- plan: Generates a `docker-compose config` in the file `stack`
- start: Start the given service
- stop: Stop the given service

To perform a plan for a container, run the following in the base directory:

```bash
$ make plan c=[service]
```

This saves the config plan to the file `stack` for your reference. Once you're
happy, start and stop the container with:

```bash
$ make start c=[service]
$ make stop c=[service]
```

### Add Service
A `docker-compose.yml` template file is available to quickly add a new service:

```bash
$ mkdir [service]
$ cp docker-compose.template.yml [service]/docker-compose.yml
```

## Borgmatic Backups
Borgmatic scripts, config and systemd files are located in `./borgmatic`.

To use, create a new user `borg` and place the following files in these directories:
- `borgmatic.service`, `borgmatic.timer` in `/etc/systemd/system`
- `remote-backup` in `/usr/local/sbin`
- `remote.yaml` in `/home/borg/`

## Other
#### sync.sh
`sync.sh` synchronizes my `.env` and `.env.example` file. When adding env variables
to `.env`, I often forget or lose track of which env variables are missing in `.env.example`.
Hence, this script automatically sychronizes them with `diff` and `patch`.

Its not great but it works ok so far :)

#### Manual execution
To manually execute compose commands inside the sub-directories, you need to add the
`--env-file` flag to ensure all env variables in `.env` are populated

```bash
$ cd traefik
$ docker-compose --env-file=../.env up -d
```
