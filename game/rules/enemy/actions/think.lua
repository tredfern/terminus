-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"

return function(enemy)
  return function(dispatch)
    local randx = math.random(-1, 1)
    local randy = math.random(-1, 1)

    dispatch(character.actions.move(
      enemy,
      enemy.x + randx,
      enemy.y + randy
    ))
  end
end