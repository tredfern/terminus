-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.actions.ladder_down", function()
  local ladderDown = require "game.rules.player.actions.ladder_down"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local mockStore = require "test_helpers.mock_store"
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
        { ladderDown = true, position = Position(1, 4, 3) }
      }
    }
    local action = ladderDown()
    mockDispatch(action)
    assert.is_true(mockDispatch:received_action("CHARACTER_MOVE"))
  end)
end)