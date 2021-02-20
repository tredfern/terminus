-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.items.actions.types"

return function(item, props)
  return {
    type = types.items_add,
    payload = {
      item = item:clone(props)
    }
  }
end