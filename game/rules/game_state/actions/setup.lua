-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"
local map = require "game.rules.map"

return function()
  return function(dispatch)
    dispatch(map.actions.set(
      map.create(50, 50)
    ))

    dispatch(character.actions.add(
      character.create {
        x = 2,
        y = 1,
        is_player_controlled = true
      }
    ))

    for _ = 1,4 do
      dispatch(character.actions.add(
        character.create {
          is_enemy = true,
          x = math.random(10),
          y = math.random(10)
        }
      ))
    end
  end
end