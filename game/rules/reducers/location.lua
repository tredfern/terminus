-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
local tables = require "moonpie.tables"

return function(state, action)
  state = state or { name = "Unknown" }
  if not action then return state end

  if action.type == types.location_update then
    return tables.assign({}, state, action.payload)
  end

  return state
end