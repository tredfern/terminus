-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.message_log.types"
local Formatter = require "game.rules.message_log.formatter"


return create_slice {
  [types.ADD] = function(state, action)
    state = state or {}
    local formatted = Formatter(action.payload.message, action.payload.formatData)
    state[#state + 1] = {
      message = formatted
    }
    return state
  end
}