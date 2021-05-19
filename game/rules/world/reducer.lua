-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local Actions = require "game.rules.world.actions"
local tables = require "moonpie.tables"


return createSlice {
  [Actions.types.ENTITY_ADD] = function(state, action)
    state[#state + 1] = action.payload.entity
    return state
  end,
  [Actions.types.ENTITY_REMOVE] = function(state, action)
    return tables.removeItem(state, action.payload.entity)
  end,
  [Actions.types.ENTITY_UPDATE] = function(state, action)
    local entity = action.payload.entity
    tables.copyKeys(action.payload.values, entity, true)
    return state
  end,
}