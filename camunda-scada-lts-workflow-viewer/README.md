# camunda-scada-lts-workflow-viewer

This service shows a small web dashboard that allows users to see which workflows have been deployed.

## Configuration

- Workflow files **MUST BE** copied/mapped into the `/srv/workflows` directory.
- The variable `SCADALTS_URL` **MUST BE** set with full path to a working ScadaLTS installation.

## Implementation details

This service leverages OpenResty which is a project combining the NGINX reverse proxy and web server with Lua scripting capabilities.

The server exposes three main resources via HTTP on port 80.

Authentication is handled by forwarding each request to the REST API of a ScadaLTS server, this logic is implemented in the [auth-via-scadalts](lua/auth-via-scadalts.lua) Lua script.

The dynamic generation of the workflow API is implemented in the [list-workflows](lua/list-workflows.lua) Lua script.

## API description

Every request must be authenticated with HTTP Basic authentication, with credentials valid for the configured `SCADALTS_URL` Scada-LTS server.

### GET /

Return the user-facing web page, allowing easy inspection of deployed workflows.

### GET /workflows

Returns an XML document containing the found workflows inside /srv/workflows

Sample document:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<workflowIndex>
  <workflows>
    <workflow filename="sample-workflow-1.bpmn">sample-workflow-1</workflow>
    <workflow filename="sample-workflow-2.bpmn">sample-workflow-2</workflow>
    <workflow filename="sample-workflow-3.bpmn">sample-workflow-3</workflow>
  </workflows>
</workflowIndex>
```

### GET /workflows/<workflow-name>

Returns either the bpmn file associated with `workflow-name` or the /workflows endpoint contents.
