-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local create_slice = require "moonpie.redux.create_slice"
local types = require "game.rules.map.actions.types"
local tables = require "moonpie.tables"

return create_slice {
  [types.ADD_ENEMY_SPAWNER] = function(state, action)
    state.enemySpawners = state.enemySpawners or {}
    state.enemySpawners[#state.enemySpawners + 1] = action.payload
    return state
  end,
  [types.REMOVE_ENEMY_SPAWNER] = function(state, action)
    state.enemySpawners = tables.select(state.enemySpawners, function(v) return v ~= action.payload.spawner end)
    return state
  end,
  [types.SET] = function(_, action)
    return action.payload
  end
}