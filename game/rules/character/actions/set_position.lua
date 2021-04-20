-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local map = require "game.rules.map"

return function(character, position)
  return {
    type = types.SET_POSITION,
    payload = {
      character = character,
      position = position
    },
    validate = function(_, state)
      local terrain = map.selectors.getTerrain(state, position)
      return not terrain.blocksMovement
    end
  }
end