-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Position = require "game.rules.world.position"
local mockStore = require "moonpie.test_helpers.mock_store"
local testStates = {}

function testStates.basicGameState()
  return mockStore {
    map = {
      outline = { width = 100, height = 100, levels = 10 }
    },
    characters = {
      { isPlayerControlled = true, position = Position(1, 1, 1), inventory = {} }
    },
    turn = {
      counter = 12
    }
  }
end


return testStates