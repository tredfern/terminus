-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.actions.types"

return create_slice {
  [types.map_add_enemy_spawner] = function(state, action)
    state.enemySpawners = state.enemySpawners or {}
    state.enemySpawners[#state.enemySpawners + 1] = action.payload
    return state
  end,
  [types.set] = function(_, action)
    return action.payload
  end
}