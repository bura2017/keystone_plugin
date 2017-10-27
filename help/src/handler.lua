-- Extending the Base Plugin handler is optional, as there is no real
-- concept of interface in Lua, but the Base Plugin handler's methods
-- can be called from your child implementation and will print logs
-- in your `error.log` file (where all logs are printed).
local BasePlugin = require "kong.plugins.base_plugin"
local CustomHandler = BasePlugin:extend()

-- Your plugin handler's constructor. If you are extending the
-- Base Plugin handler, it's only role is to instanciate itself
-- with a name. The name is your plugin name as it will be printed in the logs.
function CustomHandler:new()
  CustomHandler.super.new(self, "my-custom-plugin")
end

function CustomHandler:init_worker(config)
  -- Executed upon every Nginx worker process's startup.
  CustomHandler.super.init_worker(self)

  -- Implement any custom logic here
end

function CustomHandler:certificate(config)
  -- Executed during the SSL certificate serving phase of the SSL handshake.
  CustomHandler.super.certificate(self)

  -- Implement any custom logic here
end

function CustomHandler:rewrite(config)
  -- Executed for every request upon its reception from a client 
  -- as a rewrite phase handler. 
  CustomHandler.super.rewrite(self)

  -- Implement any custom logic here
end

function CustomHandler:access(config)
  -- Executed for every request from a client 
  -- and before it is being proxied to the upstream service.
  CustomHandler.super.access(self)

  -- Implement any custom logic here
end

function CustomHandler:header_filter(config)
  -- Executed when all response headers bytes have been received 
  -- from the upstream service.
  CustomHandler.super.header_filter(self)

  -- Implement any custom logic here
end

function CustomHandler:body_filter(config)
  -- Executed for each chunk of the response body received 
  -- from the upstream service. 
  -- Since the response is streamed back to the client, 
  -- it can exceed the buffer size and be streamed chunk by chunk. 
  -- hence this method can be called multiple times if the response is large. 
  CustomHandler.super.body_filter(self)

  -- Implement any custom logic here
end

function CustomHandler:log(config)
  -- Executed when the last response byte has been sent to the client.
  CustomHandler.super.log(self)

  -- Implement any custom logic here
end

-- This module needs to return the created table, so that Kong
-- can execute those functions.
return CustomHandler