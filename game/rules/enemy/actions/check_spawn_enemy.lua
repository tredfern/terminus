-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Character = require "game.rules.character"
local randomChance = 2

return function(spawner)
  return function(dispatch)
    local check = love.math.random(100)
    if check < randomChance then
      dispatch(Character.actions.add(
        Character.create {
          x = spawner.x,
          y = spawner.y,
          isEnemy = true
        }
      ))
    end
  end
end