-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterFactory = {}
local dice = require "moonpie.math.dice"
local attributes = require "game.rules.character.attributes"

function characterFactory.createDefaultAttributes()
  local cup = dice.parse("3d6")

  local out = {}
  for _, v in pairs(attributes) do
    out[v] = cup()
  end
  return out
end

function characterFactory.createDefaultSkills()
  return {
    throwing = 0,
    blade = 0,
    unarmed = 0,
    handgun = 0,
  }
end

function characterFactory.createDefaultInventory()
  return {
    equipSlots = {}
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
    x = props.x or 0,
    y = props.y or 0,
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    attributes = characterFactory.createDefaultAttributes(),
    skills = characterFactory.createDefaultSkills(),
    inventory = characterFactory.createDefaultInventory(),
    name = characterFactory.getName(),
    ai = props.ai
  }
  c.health = characterFactory.calculateHealth(c)

  return c
end

return characterFactory