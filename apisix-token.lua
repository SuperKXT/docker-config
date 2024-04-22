local token = os.getenv("APISIX_TOKEN")

if not token then
  ngx.log(ngx.ERR, "env APISIX_TOKEN not found")
  ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

local access_phase = ngx.router.access

access_phase = function(ctx)
  ngx.req.set_header("apisix-token", token)

  -- Call the original access phase function
  access_phase(ctx)
end

ngx.router.access = access_phase
