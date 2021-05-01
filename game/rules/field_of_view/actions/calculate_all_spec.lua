-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.actions.calculate_all", function()
  local calculateAll = require "game.rules.field_of_view.actions.calculate_all"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local mockStore = require "test_helpers.mock_store"
  local Position = require "game.rules.world.position"

  before_each(function()
    mockStore {
      world = {
        { position = Position(1, 3, 2), sightRadius = 6 },
        { position = Position(1, 3, 2), sightRadius = 4 }
      }
    }
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)


  it("finds all entities with sight enabled and calculates their visibility maps", function()
    local action = calculateAll()
    mockDispatch(action)
    assert.equals("FIELD_OF_VIEW_CALCULATE_ALL", action.type)
    assert.is_true(mockDispatch:received_action("FIELD_OF_VIEW_CALCULATE", 2))
  end)
end)