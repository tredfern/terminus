-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local types = require "game.rules.stats.types"

local function newStat()
  return {
    value = 0
  }
end

return createSlice {
  initialState = {},

  [types.COUNT] = function(state, action)
    local key = action.payload.stat
    state[key] = state[key] or newStat()

    state[key].value = state[key].value + action.payload.count

    return state
  end,
  [types.SET] = function(state, action)
    local key = action.payload.stat
    state[key] = state[key] or newStat()

    state[key].value = action.payload.value
    return state
  end
}