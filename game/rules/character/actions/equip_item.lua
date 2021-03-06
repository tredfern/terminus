-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
return function(character, item)
  return {
    type = types.EQUIP_ITEM,
    payload = {
      character = character,
      item = item
    },
    validate = function(self)
      return self.payload.item ~= nil and self.payload.item.equipSlot ~= nil
    end
  }
end