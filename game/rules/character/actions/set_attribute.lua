-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.character.actions.types"

return function(character, attribute, value)
  return {
    type = actionTypes.SET_ATTRIBUTE,
    payload = {
      character = character,
      attribute = attribute,
      value = value
    }
  }
end