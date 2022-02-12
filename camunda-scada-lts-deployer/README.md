# camunda-scada-lts-deployer

This service deploys bpmn workflows definition to the Camunda workflow automation platform.

## Usage

1. Gather your bpmn definitions in a folder
2. Set the following environment variables
   1. `CAMUNDA_HOST` Host at which Camunda exposes its REST API.
   2. `CAMUNDA_PORT` Port at which Camunda exposes its REST API.
   3. `WORKFLOWS_DIR` where bpmn workflows definitions can be found by the container.
3. Launch the container

Upon successful termination (exit code 0), workflows will be registered with Camunda.
