-- Helpers
function return_unauthorized ()
  ngx.header['WWW-Authenticate'] = 'Basic realm="ScadaLTS", charset="UTF-8"'
  ngx.exit(ngx.HTTP_UNAUTHORIZED)
end
-- Missing authorization header
if ngx.var.http_authorization == nil then
  ngx.log(ngx.INFO, 'Missing authorization header')
  return_unauthorized()
end
-- Get authorization header
local auth_b64 = string.match(ngx.var.http_authorization, '([^%s]+)$')
local auth_str = ngx.decode_base64(auth_b64)

local username = string.match(auth_str, '^([^:]+):')
local password = string.match(auth_str, ':([^:]+)$')
-- Perform subrequest
local url = os.getenv('SCADALTS_URL')..'/api/auth/'..username..'/'..password
local httpc = require("resty.http").new()
local res, err = httpc:request_uri(url)
if not res then
  ngx.log(ngx.ERR, "ScadaLTS authentication request failed: ", err)
  ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end
if res.status ~= ngx.HTTP_OK then
  ngx.log(ngx.WARN, 'ScadaLTS failed login for user', username, 'status is', res.status)
  ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end
if res.body ~= 'true' then
  ngx.log(ngx.WARN, 'ScadaLTS failed login for user', username)
  return_unauthorized()
end
ngx.log(ngx.WARN, 'ScadaLTS login successful for user', username)
ngx.exit(ngx.OK)