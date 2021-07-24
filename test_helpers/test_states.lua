-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Position = require "game.rules.world.position"
local Attributes = require "game.rules.character.attributes"
local EquipSlots = require "game.rules.inventory.equip_slots"
local mockStore = require "moonpie.test_helpers.mock_store"
local testStates = {}

function testStates.basicGameState()
  local player = testStates.basicPlayer()
  local enemy = testStates.enemy()
  return mockStore {
    map = {
      width = 100, height = 100, levels = 10,
      outline = { }, tileMap = { }
    },
    characters = {
      player,
      enemy
    },
    inventory = {
      [player] = {
        carried = {},
        equipped = {
          [EquipSlots.melee] = testStates.meleeWeapon(),
          [EquipSlots.ranged] = testStates.rangedWeapon()
        }
      }
    },
    turn = {
      counter = 12
    }
  }, player
end

function testStates.enemy()
  return {
    position = Position(1, 3, 1),
    attributes = {
      [Attributes.strength] = 3,
      [Attributes.dexterity] = 2,
      [Attributes.endurance] = 4,
      [Attributes.knowledge] = 2,
      [Attributes.intelligence] = 3,
      [Attributes.charisma] = 2
    }
  }
end

function testStates.basicPlayer()
  return {
    isPlayerControlled = true, position = Position(1, 1, 1),
    attributes = {
      [Attributes.strength] = 3,
      [Attributes.dexterity] = 2,
      [Attributes.endurance] = 4,
      [Attributes.knowledge] = 2,
      [Attributes.intelligence] = 3,
      [Attributes.charisma] = 2
    }
  }
end

function testStates.rangedWeapon()
  return {
    name = "Ranged Weapon"
  }
end

function testStates.meleeWeapon()
  return {
    name = "Melee Weapon"
  }
end

return testStates