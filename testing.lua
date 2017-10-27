--local busted = require 'busted.runner'()
local helpers = require "spec.helpers"
local cjson = require "cjson"

describe("Busted unit testing framework", function()

  local proxy_client
  local admin_client

  setup(function()
    assert(helpers.dao.apis:insert {
      name         = "test-api",
      hosts        = "test.com",
      upstream_url = "http://httpbin.org"
    })

    -- start Kong with your testing Kong configuration (defined in "spec.helpers")
    assert(helpers.start_kong())

    admin_client = helpers.admin_client()
  end)

  teardown(function()
    if admin_client then
      admin_client:close()
    end

    helpers.stop_kong()
  end)

  before_each(function()
    proxy_client = helpers.proxy_client()
  end)

  after_each(function()
    if proxy_client then
      proxy_client:close()
    end
  end)

  describe("should be awesome", function()
    it("should create tenant entity with name \"admin\"", function()
      -- send requests through Kong
      local res = assert(proxy_client:send {
        method = "POST",
        path   = "/v2.0/tenants",
        headers = {
          ["Host"] = "test.com"
        },
        message = {
            tenant = {
                name = "admin"
            }
        }
      })

      local res = assert.res_status(200, res)
      local body = cjson.decode(res)

      -- body is a string containing the response
    end)
  end)
end)