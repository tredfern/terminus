-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterFactory = {}
local attributes = require "game.rules.character.attributes"
local Position = require "game.rules.world.position"
local tables = require "moonpie.tables"

local START_BUY_POINTS = 6

function characterFactory.createDefaultAttributes()
  local spread = attributes.pointBuyStart()

  return {
    buyPoints = START_BUY_POINTS,
    [attributes.strength] = tables.popRandom(spread),
    [attributes.dexterity] = tables.popRandom(spread),
    [attributes.endurance] = tables.popRandom(spread),
    [attributes.intelligence] = tables.popRandom(spread),
    [attributes.knowledge] = tables.popRandom(spread),
    [attributes.charisma] = tables.popRandom(spread),
  }
end

function characterFactory.getName()
  local names = require "game.rules.character.names"
  local n = names.generate()
  return string.format("%s %s", n.first or "" , n.last or "")
end

function characterFactory.calculateHealth(character)
  return 10 + character.attributes[attributes.endurance]
end

function characterFactory.newCharacter(props)
  props = props or {}
  local c = {
    position = props.position or Position(0, 0, 0),
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    attributes = characterFactory.createDefaultAttributes(),
    skills = {},
    name = characterFactory.getName(),
    ai = props.ai
  }
  c.health = characterFactory.calculateHealth(c)

  return c
end

return characterFactory