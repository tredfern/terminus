-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Character = require "game.rules.character"

return function(item, user)
  return function(dispatch)
    item:useHandler(user)
    dispatch(Character.actions.removeItemFromInventory(user, item))
  end
end