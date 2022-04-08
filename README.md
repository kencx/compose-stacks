# Compose Stacks

Repository of docker-compose .yaml files of my self-hosted applications and services.

## Use

### Docker network
Most of the services use nginx-proxy-manager as a reverse proxy. This requires
the creation of an external docker network **prior** to starting any containers.

As for as I know, there is no easy way of creating an external network
[programmatically](https://github.com/docker/compose/issues/2846), nor are
[pre-hook](https://github.com/docker/compose/issues/1341) scripts supported.
Ensure the network is created with:

```bash
$ docker network create proxy
$ docker network create socket-proxy
```

The network name matches that of all compose files. This cannot be configured
with `.env` as environment variables cannot be passed into yaml keys.

### Environment Variables
Rename `.env.example` to `.env` in the root directory. This is the global
configuration file for all containers.

```bash
$ cp .env.example .env
```

Each sub-directory contains a base `docker-compose.yml` file and relevant
`[service].env` file for container specific configuration.

Change the env vars in each `[service].env` to your liking.

### Plan, Start, Stop
To perform a plan
for a container, run the following in the root directory:

```bash
$ make plan c=[service]
```

This saves the config plan to the `stack` file for your reference. Once you're
happy, start and stop the container with:

```bash
$ make start c=[service]
$ make stop c=[service]
```

### Add Service
A docker-compose template file is available to quickly add a new service:

```bash
$ mkdir [service]
$ cp docker-compose.template.yml [service]/docker-compose.yml
```

## Borgmatic
Borgmatic scripts, config and systemd files are located in `./borgmatic`.

To use, create a new user `borg` and place the following files in these directories:
- `borgmatic.service`, `borgmatic.timer` in `/etc/systemd/system`
- `remote-backup` in `/usr/local/sbin`
- `remote.yaml` in `/home/borg/`

## TODO
- Secrets management
- Overrides compose files for different envs
