-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local removeItemFromInventory = require "game.rules.character.actions.remove_item_from_inventory"

return function(item, user)
  return function(dispatch)
    item:useHandler(dispatch, user)
    if item.consumeOnUse then
      dispatch(removeItemFromInventory(user, item))
    end
  end
end