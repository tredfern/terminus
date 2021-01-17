-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character, health)
  return {
    type = types.character_set_health,
    payload = {
      character = character,
      health = health
    }
  }
end