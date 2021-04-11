-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.actions.types"

return create_slice {
  [types.ADD] = function(state, action)
    state.outline = action.payload.outline
    state.tileMap = action.payload.tileMap
    return state
  end,
}