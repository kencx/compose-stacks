# Compose Stacks

Repository of docker-compose .yaml files of my self-hosted applications and services.

## Use
Rename `.env.example` to `.env` in the root directory. This is the global
configuration file for all containers.

Each sub-directory contains a base `docker-compose.yml` file and relevant
`[service].env` file for container specific configuration.

Change the env vars in each `*.env` to your liking. To debug your config, run

```bash
$ docker-compose --env-file=../.env config
```

When starting a service, run into the sub-directory.

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
