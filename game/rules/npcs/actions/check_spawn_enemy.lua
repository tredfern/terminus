-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Aliens = require "game.rules.aliens"
local randomChance = 2

return function(spawner)
  return function(dispatch)
    local check = love.math.random(100)
    if check < randomChance then
      dispatch(Aliens.actions.addAlien(spawner.position.x, spawner.position.y))
    end
  end
end