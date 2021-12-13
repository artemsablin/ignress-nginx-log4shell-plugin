local ngx = ngx

local _M = {}

function _M.rewrite()
  local req_headers = "Headers: ";
  local h, err = ngx.req.get_headers()
  for k, v in pairs(h) do
    req_headers = req_headers .. k .. ": " .. v .. "\n";
    if v and string.match(v, "jndi") then
      ngx.exit(ngx.HTTP_FORBIDDEN)
    else
      if err then
        ngx.log(ngx.ERR, "error: ", err)
        return
      end
    end
  end
end

return _M
