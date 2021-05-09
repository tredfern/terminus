-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.actions.calculate", function()
  local calculate = require "game.rules.field_of_view.actions.calculate"
  local Position = require "game.rules.world.position"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

  before_each(function()
    mockDispatch.processComplex = true
  end)

  after_each(function()
    mockDispatch:reset()
  end)

  it("calculates the field of view and then updates", function()
    local entity = {}
    local position = Position(4, 2, 3)

    local action = calculate(entity, position, 3)
    assert.equals("FIELD_OF_VIEW_CALCULATE", action.type)
    mockDispatch(action)
    assert.is_true(mockDispatch:received_action("FIELD_OF_VIEW_UPDATE"))
  end)
end)