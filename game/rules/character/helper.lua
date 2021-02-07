-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local characterHelper = {}
local dice = require "moonpie.math.dice"

function characterHelper.createDefaultAttributes()
  local attributes = require "game.rules.character.attributes"
  local cup = dice.parse("3d6")

  local out = {}
  for _, v in pairs(attributes) do
    out[v] = cup()
  end
  return out
end

function characterHelper.createDefaultSkills()
  return {
    throwing = 0,
    blade = 0,
    unarmed = 0,
    handgun = 0,
  }
end

function characterHelper.createDefaultInventory()
  return {}
end

function characterHelper.newCharacter(props)
  props = props or {}
  local c = {
    x = props.x or 0,
    y = props.y or 0,
    isPlayerControlled = props.isPlayerControlled,
    isEnemy = props.isEnemy,
    health = 10,
    attributes = characterHelper.createDefaultAttributes(),
    skills = characterHelper.createDefaultSkills(),
    inventory = characterHelper.createDefaultInventory()
  }

  return c
end

return characterHelper