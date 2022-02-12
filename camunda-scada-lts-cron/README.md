# camunda-scada-lts-cron

This service handles the repeated invocation of user provided executables or shell scripts.

## Configuration

Four environment variables are needed:

- `CAMUNDA_HOST` which is the hostname of Camunda
- `CAMUNDA_PORT` which is the port of Camunda
- `CRON_DIR` which is the folder containing the target scripts.
- `INTERVAL_SECONDS` which is the amount of seconds to wait between jobs.

*At least one program should be present inside CRON_DIR for this service to work*
