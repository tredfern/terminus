-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"

return function(character, x, y)
  return {
    type = types.character_move,
    payload = {
      character = character,
      x = x,
      y = y
    }
  }
end