-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local types = require "game.rules.actions.types"
local tables = moonpie.utility.tables

local function initial_state()
  return {
    spaceports = {},
    location = { name = "Unknown" }
  }
end

return function(state, action)
  state = state or initial_state()
  if not action then
    return state
  end

  if action.type == types.spaceport_add then
    return tables.assign({}, state, {
      spaceports = tables.concat_array(state.spaceports, { action.payload })
    })
  end

  if action.type == types.location_update then
    return tables.assign({}, state, {
      location = action.payload
    })
  end

  return state
end