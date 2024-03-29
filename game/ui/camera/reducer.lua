-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.ui.camera.actions.types"
local createSlice = require "moonpie.redux.create_slice"

return createSlice {
  initialState = function() return {
    x = 1,
    y = 1,
    z = 1
  } end,
  [types.camera_set_dimensions] = function(state, action)
    state.width = action.payload.width
    state.height = action.payload.height
    return state
  end,
  [types.camera_set_position] = function(state, action)
    state.x = action.payload.x
    state.y = action.payload.y
    state.z = action.payload.z
    return state
  end
}