-- Helpers
function print_workflow (file)
  local filename = string.match(file, '/([^/]+)$')
  local file_no_ext = string.match(filename, '(.+)[.]bpmn$')
  ngx.say('    <workflow filename="'..filename..'">'..file_no_ext..'</workflow>')
end
function print_workflows ()
  local shell = require "resty.shell"
  local ok, stdout, stderr, reason, status = shell.run([[find /srv/workflows -type f -name '*.bpmn']])
  for file in string.gmatch(stdout, '([^%s]+)') do
    print_workflow(file)
  end
end
-- Send content type
ngx.header.content_type = 'text/xml'
-- Header
ngx.say('<?xml version="1.0" encoding="UTF-8"?>')
ngx.say('<workflowIndex>')
-- Workflows
ngx.say('  <workflows>')
print_workflows()
ngx.say('  </workflows>')
-- Close file
ngx.say('</workflowIndex>')