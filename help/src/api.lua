local crud = require "kong.api.crud_helpers"

return {
    ["/:username"] = {
        before = function(self) end,
        on_error = function(self, helpers) 
            helpers.yield_error()
        end,
        POST = function(self, dao_factory)
            crud.post(self)
        end
    }
}