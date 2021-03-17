-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(char, dispatch)
  local character = require "game.rules.character"
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)

  dispatch(character.actions.move(char, char.x + x, char.y + y))
end