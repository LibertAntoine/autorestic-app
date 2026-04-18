# Autorestic App

Autorestic App is a Docker image that runs autorestic backups on a schedule. It is designed to be 
used with a Postgres database, but can be used with any autorestic configuration.

Autorestic App is based on the [official autorestic image](https://hub.docker.com/r/cupcakearmy/autorestic), with the addition of the Postgres client and a cron scheduler.
It runs a cron job that executes the autorestic backup command according to the schedule defined in the `CRON_SCHEDULE` environment variable.

### Configuration

* `CRON_SCHEDULE` : Cron schedule for backup (default: `*/5 * * * *`)
* `AUTORESTIC_CONFIG` : Path to autorestic config file (default: `/data/.autorestic.yml`)