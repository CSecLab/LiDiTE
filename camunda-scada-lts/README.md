# camunda-scada-lts

This service bundles together Camunda and Scada LTS, the reasoning behind this coupling is the same as per Ditto: in order to spare the resources needed to execute two separate Tomcat application servers.

## Configuration

The following environment variables must be provided:

- `DB_HOST` the database server hostname
- `DB_PORT` the database server port
- `CAMUNDA_DB_NAME` the Camunda database username
- `CAMUNDA_DB_PASS` the Camunda database password
- `SCADA_DB_NAME` the ScadaLTS database username
- `SCADA_DB_PASS` the ScadaLTS database password

Additionally, images contained in ScadaLTS dashboards must be put inside a folder and mounted at the `/scada-lts-uploads` path.
