-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"

return function(character, item)
  return {
    type = types.character_add_item_to_inventory,
    payload = {
      character = character,
      item = item
    }
  }
end