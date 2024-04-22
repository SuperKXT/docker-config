return function()
	local core = require \"apisix.core\";
	local token = os.getenv(\"APISIX_TOKEN\");
	if not token then
		ngx.status = 500;
		ngx.say('{ \"error\": \"env_missing\", \"error_description\": \"env APISIX_TOKEN not found\" }');
       	ngx.exit(ngx.HTTP_OK);
	end
	core.request.set_header(\"apisix-token\", token);
end
