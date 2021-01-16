-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local map = require "game.rules.map"

return function(character, x, y)
  return {
    type = types.character_set_position,
    payload = {
      character = character,
      x = x,
      y = y
    },
    validate = function(self, state)
      local dims = map.selectors.get_dimensions(state)
      return self.payload.x >= 1 and self.payload.x < dims.width and
        self.payload.y >= 1 and self.payload.y < dims.height
    end
  }
end