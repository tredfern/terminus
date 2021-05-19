-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Thunk = require "moonpie.redux.thunk"
local Aliens = require "game.rules.aliens"

local Actions = {}
Actions.types = {
  CHECK_SPAWN_ENEMY = "NPCS_CHECK_SPAWN_ENEMY",
  THINK = "NPCS_THINK"
}
local randomChance = 2

function Actions.checkSpawnEnemy(spawner)
  return Thunk(Actions.types.CHECK_SPAWN_ENEMY, function(dispatch)
    local check = love.math.random(1000)
    if check < randomChance then
      dispatch(Aliens.actions.addAlien(spawner.position))
    end
  end)
end

function Actions.think(enemy)
  return Thunk(Actions.types.THINK, function(dispatch, getState)
    enemy:ai(dispatch, getState)
  end)
end
return Actions