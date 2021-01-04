-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character, x, y)
  local set_position = require "game.rules.character.actions.set_position"

  return setmetatable({
    type = types.character_move,
  },
  {
    __call = function(_, dispatch)
      dispatch(set_position(character, x, y))
    end
  })
end