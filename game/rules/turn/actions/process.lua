-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local increment = require "game.rules.turn.actions.increment"
local Character = require "game.rules.character"
local Enemy = require "game.rules.enemy"
local Camera = require "game.ui.camera"
local GameState = require "game.rules.game_state"

return function(player_action)
  return function(dispatch, getState)
    dispatch(increment())
    dispatch(player_action)

    local enemies = Character.selectors.getEnemies(getState())
    if enemies then
      for _, e in ipairs(enemies) do
        dispatch(Enemy.actions.think(e))
      end
    end

    -- Check for dead characters
    local dead = Character.selectors.getDead(getState())
    if dead then
      local playerDied = false
      for _, e in ipairs(dead) do
        playerDied = playerDied or e.is_player_controlled
        dispatch(Character.actions.remove(e))
      end

      if playerDied then
        dispatch(GameState.actions.gameOver())
        return
      end
    end

    -- Update camera position to follow character
    local cam = Camera.selectors.get(getState())
    if cam then
      dispatch(Camera.actions.centerOnPlayer(cam.width, cam.height))
    end
  end
end