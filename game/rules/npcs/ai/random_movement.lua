-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT



return function(char, dispatch)
  local Position = require "game.rules.world.position"
  local character = require "game.rules.character"
  local x = love.math.random(-1, 1)
  local y = love.math.random(-1, 1)

  dispatch(character.actions.move(char, Position(char.position.x + x, char.position.y + y)))
end