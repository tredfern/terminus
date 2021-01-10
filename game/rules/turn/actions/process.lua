-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local increment = require "game.rules.turn.actions.increment"
local character = require "game.rules.character"
local enemy = require "game.rules.enemy"

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
  end
end