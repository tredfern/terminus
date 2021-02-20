-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local character = require "game.rules.character"

return function(char, dispatch)
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)

  dispatch(character.actions.move(char, char.x + x, char.y + y))
end