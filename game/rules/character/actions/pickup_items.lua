-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local addItemToInventory = require "game.rules.character.actions.add_item_to_inventory"
local Items = require "game.rules.items"
local Position = require "game.rules.world.position"

return function(character)
  return function(dispatch, getState)

    local itemsInPosition = Items.selectors.getByPosition(getState(),
      Position(character.position.x, character.position.y))
    for _, v in ipairs(itemsInPosition) do
      dispatch(addItemToInventory(character, v))
      dispatch(Items.actions.remove(v))
    end
  end
end