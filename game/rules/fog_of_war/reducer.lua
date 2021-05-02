-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local actionTypes = require "game.rules.fog_of_war.actions.types"

return createSlice {
  [actionTypes.UPDATE_POSITION] = function(state, action)
    local perspective = action.payload.perspective
    local pos = action.payload.position
    local key = action.payload.positionHashKey or pos.hashKey
    local tile = action.payload.tile

    if not state[perspective] then state[perspective] = {} end

    state[perspective][key] = {
      tile = tile
    }

    return state
  end
}