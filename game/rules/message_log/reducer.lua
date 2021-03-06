-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.message_log.actions.types"


return create_slice {
  [types.ADD] = function(state, action)
    state = state or {}
    state[#state + 1] = action.payload
    return state
  end
}