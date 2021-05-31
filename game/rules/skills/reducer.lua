-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local types = require "game.rules.skills.types"

return createSlice {
  [types.DEFINE] = function(state, action)
    state[action.payload.key] = {
      name = action.payload.name,
      ability = action.payload.ability,
      untrainedPenalty = action.payload.untrainedPenalty
    }
    return state
  end
}