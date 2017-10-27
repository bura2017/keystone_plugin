local BasePlugin = require "kong.plugins.base_plugin"

local KeystoneHandler = BasePlugin:extend()

function KeystoneHandler:new()
  KeystoneHandler.super.new(self, "keystone")
end

function KeystoneHandler:access(config)
  KeystoneHandler.super.access(self)

  print(config.token_expiration) -- {"apikey"}
end

return KeystoneHandler
