-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.ladder_up", function()
  local ladderUp = require "game.rules.player.actions.ladder_up"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Position = require "game.rules.world.position"

  before_each(function()
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("moves up if there is a ladder in the current location", function()
    mockStore {
      characters = {},
      world = {
        { isPlayerControlled = true, position = Position(1, 4, 3)},
        { ladderUp = true, position = Position(1, 4, 3) }
      }
    }
    local action = ladderUp()
    mockDispatch(action)
    assert.is_true(mockDispatch:received_action("CHARACTER_MOVE"))
  end)
end)