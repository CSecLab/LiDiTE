#!/bin/sh
set -e
# Check vars
if [ -z "${CRON_DIR}" ]; then
  echo "CRON_DIR is not set"
  exit 1
fi
if [ -z "${INTERVAL_SECONDS}" ]; then
  echo "INTERVAL_SECONDS is not set"
  exit 1
fi
# Deploy
wait-for-it "${CAMUNDA_HOST}:${CAMUNDA_PORT}" -- echo 'Camunda is alive'
while true; do
  sleep "${INTERVAL_SECONDS}"
  for f in "${CRON_DIR}"/*; do
    if [ -x "$f" ]; then
      # Executable
      echo "Running $f"
      "$f"
    else
      # Shell script
      echo "Running script $f"
      if [ -x "$(command -v bash)" ]; then
        bash "$f"
      else
        sh "$f"
      fi
    fi
  done
  echo ""
done