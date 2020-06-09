-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

local function initial_state()
  return {
    money = 0
  }
end

return function(state, action)
  state = state or initial_state()
  if action == nil then return state end

  if action.type == types.money_update then
    return tables.assign({}, state, { money = action.payload.amount })
  end

  if action.type == types.money_adjust then
    return tables.assign({}, state, { money = state.money + action.payload.amount })
  end

  return state
end