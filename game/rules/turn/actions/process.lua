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

    -- Update camera position to follow character
    local cam = camera.selectors.get(get_state())
    if cam then
      local player = character.selectors.get_player(get_state())
      dispatch(camera.actions.set_position(
        -(cam.width / 2) + player.x,
        -(cam.height / 2) + player.y
      ))
    end
  end
end