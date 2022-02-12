#!/bin/sh
set -e
# Check vars
if [ -z "${WORKFLOWS_DIR}" ]; then
  echo "WORKFLOWS_DIR is not set"
  exit 1
fi
# Deploy
wait-for-it "${CAMUNDA_HOST}:${CAMUNDA_PORT}" -- echo 'Camunda is alive'
for workflow in "${WORKFLOWS_DIR}"/*.bpmn; do
  workflow_name=$(basename "$workflow" | rev | cut -d'.' -f 2- | rev)
  echo "Deploying ${workflow} as ${workflow_name}"
  curl -w "\n" --cookie /tmp/cookie.txt \
    -H "Accept: application/json" \
    -F "deployment-name=${workflow_name}" \
    -F "enable-duplicate-filtering=false" \
    -F "deploy-changed-only=false" \
    -F "process.bpmn=@$workflow" \
    "http://${CAMUNDA_HOST}:${CAMUNDA_PORT}/engine-rest/engine/default/deployment/create"
done
