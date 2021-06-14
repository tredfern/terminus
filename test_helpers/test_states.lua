-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Position = require "game.rules.world.position"
local Attributes = require "game.rules.character.attributes"
local mockStore = require "moonpie.test_helpers.mock_store"
local testStates = {}

function testStates.basicGameState()
  local player = {
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
  return mockStore {
    map = {
      width = 100, height = 100, levels = 10,
      outline = { }, tileMap = { }
    },
    characters = {
      player
    },
    inventory = {
      [player] = {
        carried = {},
        equipped = {}
      }
    },
    turn = {
      counter = 12
    }
  }, player
end


return testStates