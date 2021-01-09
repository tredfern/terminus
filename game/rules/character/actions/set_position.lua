-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character, x, y)
  return {
    type = types.character_set_position,
    payload = {
      character = character,
      x = x,
      y = y
    }
  }
end