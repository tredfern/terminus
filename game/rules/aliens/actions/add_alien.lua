-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Characters = require "game.rules.character"
local Animator = require "game.rules.graphics.animator"
local alienIdle = require "assets.bestiary.alien"

local aiRoutines = {
  require "game.rules.npcs.ai.move_towards_player",
  require "game.rules.npcs.ai.random_movement"
}

return function(position)
  local alien = Characters.create { position = position, isEnemy = true, ai = tables.pickRandom(aiRoutines) }
  alien.alien = true
  alien.animator = Animator:new()
  alien.animator:addAnimation("idle", alienIdle)
  alien.animator:play("idle")
  return Characters.actions.add(alien)
end