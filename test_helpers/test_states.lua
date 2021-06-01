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
      [Attributes.agility] = 2,
      [Attributes.endurance] = 4,
      [Attributes.education] = 2,
      [Attributes.wit] = 3,
      [Attributes.social] = 2
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