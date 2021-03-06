-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.message_log.actions.types"

return function(message)
  return {
    type = types.ADD,
    payload = {
      message = message
    }
  }
end