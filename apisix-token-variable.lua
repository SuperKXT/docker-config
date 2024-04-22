function()
	local core = require "apisix.core"
	local token = os.getenv("APISIX_TOKEN")
	if not token then
		ngx.log(ngx.ERR, "env APISIX_TOKEN not found")
		ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
	end
	core.ctx.register_var("apisix-token", token);
end
