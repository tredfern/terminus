-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local increment = require "game.rules.turn.actions.increment"
local character = require "game.rules.character"
local enemy = require "game.rules.enemy"
local camera = require "game.rules.camera"

return function(player_action)
  return function(dispatch, get_state)
    dispatch(increment())
    dispatch(player_action)

    local enemies = character.selectors.get_enemies(get_state())
    if enemies then
      for _, e in ipairs(enemies) do
        dispatch(enemy.actions.think(e))
      end
    end

    -- Check for dead characters
    local dead = character.selectors.get_dead(get_state())
    if dead then
      for _, e in ipairs(dead) do
        dispatch(character.actions.remove(e))
      end
    end

    -- Update camera position to follow character
    local cam = camera.selectors.get(get_state())
    if cam then
      dispatch(camera.actions.center_on_player(cam.width, cam.height))
    end
  end
end