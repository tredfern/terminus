-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local actionTypes = require "game.rules.items.actions.types"

return createSlice {
  initialState = {},
  [actionTypes.items_add] = function(state, action)
    state[#state + 1] = action.payload.item
    return state
  end
}