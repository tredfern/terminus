-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characters = require "game.rules.character"
local sprite = require "game.graphics.sprite"

return function(x, y)
  local c = characters.create { x = x, y = y, isPlayerControlled = true }
  c.sprite = sprite.fromFile("assets/graphics/simple-character-1.png")
  return characters.actions.add(c)
end