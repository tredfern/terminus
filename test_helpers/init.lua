-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

require "moonpie.test_helpers.busted_extensions"
moonpie = require "moonpie"
require "test_helpers.matchers"
require "test_helpers.thunk_assertions"
require "test_helpers.component_assertions"

local Cache = require "game.cache"
Cache.disabled()

moonpie.testing = {}
moonpie.testing.simpleSpy = function()
  local spy = require "luassert.spy"
  return spy.new(function() end)
end