-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local increment = require "game.rules.turn.actions.increment"
local Character = require "game.rules.character"
local NPCs = require "game.rules.npcs"
local Camera = require "game.ui.camera"
local GameState = require "game.rules.game_state"
local Map = require "game.rules.map"

return function(player_action)
  return function(dispatch, getState)
    dispatch(increment())
    dispatch(player_action)

    local enemies = NPCs.selectors.getEnemies(getState())
    if enemies then
      for _, e in ipairs(enemies) do
        dispatch(NPCs.actions.think(e))
      end
    end

    local spawners = Map.selectors.getEnemySpawners(getState())
    if spawners then
      for _, spawner in ipairs(spawners) do
        dispatch(NPCs.actions.checkSpawnEnemy(spawner))
      end
    end

    -- Check for dead characters
    local dead = Character.selectors.getDead(getState())
    if dead then
      for _, e in ipairs(dead) do
        dispatch(Character.actions.remove(e))
      end
    end

    -- Update camera position to follow character
    local cam = Camera.selectors.get(getState())
    if cam then
      dispatch(Camera.actions.centerOnPlayer(cam.width, cam.height))
    end

    dispatch(GameState.actions.checkGameOver())
  end
end