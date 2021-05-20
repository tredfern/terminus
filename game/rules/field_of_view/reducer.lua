-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local actionTypes = require "game.rules.field_of_view.types"

return createSlice {
  [actionTypes.UPDATE] = function(state, action)
    state[action.payload.entity] = action.payload.visibilityMap
    return state
  end
}