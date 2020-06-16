-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local message = require "game.entities.message"
local types = require "game.rules.actions.types"

return function(msg)
  return {
    type = types.message_add,
    payload = message(msg)
  }
end