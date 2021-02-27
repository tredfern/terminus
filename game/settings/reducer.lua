-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local types = require "game.settings.actions.types"

return createSlice {
  [types.settings_set_option] = function(state, action)
    state[action.payload.name] = action.payload.value
    return state
  end,
  [types.settings_toggle_option] = function(state, action)
    state[action.payload.name] = not state[action.payload.name]
    return state
  end
}