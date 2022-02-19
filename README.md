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
```

The network name matches that of all compose files. This cannot be configured
with `.env` as environment variables cannot be passed into yaml keys.

### Environment Variables
Rename `.env.example` to `.env` in the root directory. This is the global
configuration file for all containers.

Each sub-directory contains a base `docker-compose.yml` file and relevant
`[service].env` file for container specific configuration.

Change the env vars in each `[service].env` to your liking. To debug your config, run

```bash
$ docker-compose --env-file=../.env config
```

When starting a service, `cd` into the sub-directory.

```bash
$ docker-compose --env-file=../.env up -d
```

## Borgmatic
Borgmatic scripts, config and systemd files are located in `./borgmatic`.

To use, create a new user `borg` and place the following files in these directories:
- `borgmatic.service`, `borgmatic.timer` in `/etc/systemd/system`
- `remote-backup` in `/usr/local/sbin`
- `remote.yaml` in `/home/borg/`

## TODO
- Shell script for compose commands
- Secrets management
- Overrides compose files for different envs
