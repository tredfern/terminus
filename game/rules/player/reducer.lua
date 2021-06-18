-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local createSlice = require "moonpie.redux.create_slice"
local utility = require "moonpie.utility"
local types = require "game.rules.player.types"

return createSlice {
  [types.SET_HOT_KEY] = function(state, action)
    state.hotkeys = state.hotkeys or {}
    state.hotkeys[action.payload.hotkey] = {
      name = action.payload.name,
      image = action.payload.image,
      handler = action.payload.handler
    }
    return state
  end,
  [types.TRACK_ROOM_VISIT] = function(state, action)
    utility.ensureKey(state, "roomVisits", {})
    state.roomVisits[action.payload.room] = true
    return state
  end
}