-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addItemToInventory = require "game.rules.character.actions.add_item_to_inventory"
local Items = require "game.rules.items"

return function(character)
  return function(dispatch, getState)

    local itemsInPosition = Items.selectors.getByPosition(getState(), character.x, character.y)
    for _, v in ipairs(itemsInPosition) do
      dispatch(addItemToInventory(character, v))
    end
  end
end