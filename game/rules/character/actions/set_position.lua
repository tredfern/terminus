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
      local terrain = map.selectors.getTerrain(state, self.payload.x, self.payload.y)
      return not terrain.blocks_movement
    end
  }
end