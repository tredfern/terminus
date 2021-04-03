-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local actionTypes = require "game.rules.world.actions.types"
local tables = require "moonpie.tables"


return createSlice {
  [actionTypes.ENTITY_ADD] = function(state, action)
    state[#state + 1] = action.payload.entity
    return state
  end,
  [actionTypes.ENTITY_REMOVE] = function(state, action)
    return tables.removeItem(state, action.payload.entity)
  end

}