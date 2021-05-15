-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"

return createSlice {
  ["ANIMATION_PLAY_ONCE"] = function(state, action)
    action.payload.animator:playOnce(action.payload.animation)
    return state
  end
}