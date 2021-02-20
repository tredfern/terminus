-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.items.actions.types"

return function(item)
  return {
    type = actionTypes.remove,
    payload = { item = item }
  }
end