-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

local function clone_market_item(name, state)
  local m = state[name] or {}
  return {
    name = name,
    price = m.price or 0
  }
end

return function(state, action)
  state = state or {}
  if not action then return state end

  if action.type == types.market_add_item then
    local mi = clone_market_item(action.payload.name, state)
    mi.price = action.payload.price
    return tables.assign({}, state, { [action.payload.name] = mi })
  end

  return state
end