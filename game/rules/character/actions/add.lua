-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character)
  return {
    type = types.character_add,
    payload = {
      character = character
    }
  }
end