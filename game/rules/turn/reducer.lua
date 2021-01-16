-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.turn.actions.types"

return create_slice({
  initial_state = {
    counter = 0
  },
  [types.increment] = function(state)
    if not state.counter then
      state.counter = 1
    else
      state.counter = state.counter + 1
    end
    return state
  end
})