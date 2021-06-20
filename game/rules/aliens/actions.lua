-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local tables = require "moonpie.tables"
local sprite = require "game.rules.graphics.sprite"
local Animator = require "game.rules.graphics.animator"
local World = require "game.rules.world"
local Behaviors = require "game.rules.npcs.behaviors"

local aiRoutines = {
  Behaviors.moveTowardsPlayer,
  Behaviors.randomMovement
}

local Actions = {}

function Actions.addAlien(position)
  local Characters = require "game.rules.character"
  local alienIdle = require "assets.bestiary.alien"

  local alien = Characters.create { position = position, isEnemy = true, ai = tables.pickRandom(aiRoutines) }
  alien.alien = true
  alien.animator = Animator:new()
  alien.animator:addAnimation("idle", alienIdle)
  alien.animator:play("idle")
  return Characters.actions.add(alien)
end

function Actions.addSpawner(position)
  return World.actions.addEntity {
    position = position,
    spawner = true,
    sprite = sprite.fromFile("assets/graphics/spawner.png")
  }
end

function Actions.removeSpawner(spawner)
  return World.actions.removeEntity(spawner)
end

return Actions