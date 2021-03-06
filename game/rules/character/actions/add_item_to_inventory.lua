-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character, item)
  return {
    type = types.ADD_ITEM_TO_INVENTORY,
    payload = {
      character = character,
      item = item
    }
  }
end