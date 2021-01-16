-- Copyright (c) 2021 Trevor Redfern
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.camera.actions.types"
local create_slice = require "moonpie.redux.create_slice"

return create_slice {
  initial_state = { 
    x = 1,
    y = 1
  },
  [types.camera_set_position] = function(state, action)
    state.x = action.payload.x
    state.y = action.payload.y
    return state
  end
}