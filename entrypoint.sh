#!/bin/bash
set -e

CRON_SCHEDULE="${CRON_SCHEDULE:-*/5 * * * *}"
AUTORESTIC_CONFIG="${AUTORESTIC_CONFIG:-/data/.autorestic.yml}"

# crond doesn't load env vars from /etc/profile, 
# so we export them to a file and source it in the crontab
declare -px > /etc/autorestic.env

if [ "${AUTORESTIC_SKIP_INIT}" != "true" ]; then
    echo "[entrypoint] Running autorestic check..."
    if ! autorestic -c "${AUTORESTIC_CONFIG}" --verbose check; then
        echo "[entrypoint] ERROR: autorestic check failed. Stopping container."
        exit 1
    fi
else
    echo "[entrypoint] AUTORESTIC_SKIP_INIT=true — check ignored."
fi

mkdir -p /var/spool/cron/crontabs
cat > /var/spool/cron/crontabs/root <<CRONTAB
PATH=/usr/local/bin:/usr/bin:/bin
${CRON_SCHEDULE} . /etc/autorestic.env && autorestic -c ${AUTORESTIC_CONFIG} --ci cron >> /proc/1/fd/1 2>&1
CRONTAB
chmod 600 /var/spool/cron/crontabs/root

echo "[entrypoint] Config    : ${AUTORESTIC_CONFIG}"
echo "[entrypoint] Cron schedule : ${CRON_SCHEDULE}"
exec crond -f -l 8