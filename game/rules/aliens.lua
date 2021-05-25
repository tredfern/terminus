-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local sprite = require "game.rules.graphics.sprite"
local Animator = require "game.rules.graphics.animator"
local World = require "game.rules.world"

local Aliens = {
  actions = {},
  selectors = {}
}

local Behaviors = require "game.rules.npcs.behaviors"
local aiRoutines = {
  Behaviors.moveTowardsPlayer,
  Behaviors.randomMovement
}

function Aliens.actions.addAlien(position)
  local Characters = require "game.rules.character"
  local alienIdle = require "assets.bestiary.alien"

  local alien = Characters.create { position = position, isEnemy = true, ai = tables.pickRandom(aiRoutines) }
  alien.alien = true
  alien.animator = Animator:new()
  alien.animator:addAnimation("idle", alienIdle)
  alien.animator:play("idle")
  return Characters.actions.add(alien)
end

function Aliens.actions.addSpawner(position)
  return World.actions.addEntity {
    position = position,
    spawner = true,
    sprite = sprite.fromFile("assets/graphics/spawner.png")
  }
end

function Aliens.actions.removeSpawner(spawner)
  return World.actions.removeEntity(spawner)
end

function Aliens.selectors.getSpawnerAt(state, position)
  return World.selectors.getByPosition(state, position, "spawner")[1]
end

function Aliens.selectors.getSpawners(state)
  return World.selectors.getAllWithComponents(state, "spawner")
end

return Aliens