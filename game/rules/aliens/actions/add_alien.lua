-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Characters = require "game.rules.character"
local sprite = require "game.rules.graphics.sprite"
local aiRoutines = {
  require "game.rules.npcs.ai.move_towards_player",
  require "game.rules.npcs.ai.random_movement"
}

return function(x, y)
  local alien = Characters.create { x = x, y = y, isEnemy = true, ai = tables.pickRandom(aiRoutines) }
  alien.alien = true
  alien.sprite = sprite.fromFile("assets/graphics/alien_1.png")
  return Characters.actions.add(alien)
end