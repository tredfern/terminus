-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character)
  return {
    type = types.ADD,
    payload = {
      character = character
    }
  }
end