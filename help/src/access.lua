local singletons = require "kong.singletons"
local dao = singletons.dao
local keys_dao = dao_factory.keyauth_credentials
local key_credential, err = keys_dao:insert({
  consumer_id = consumer.id,
  key = "abcd"
})
