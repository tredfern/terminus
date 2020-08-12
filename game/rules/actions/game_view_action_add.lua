-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"

return function(text, action)
  return {
    type = types.game_view_action_add,
    payload = {
      text = text,
      action = action
    }
  }
end