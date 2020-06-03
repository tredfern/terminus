-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

return function(state, action)
  state = state or {}
  if not action then return state end

  if action.type == types.market_add_item then
    local new_item = true
    local market_items = tables.map(state, function(mi)
      if mi.name == action.payload.name then
        new_item = false
        return { name = mi.name, price = action.payload.price }
      end
      return mi
    end)

    if new_item then
      market_items = tables.concat_array(
        market_items,
        { { name = action.payload.name, price = action.payload.price }}
      )
    end

    return tables.assign({}, state, market_items)
  end

  return state
end