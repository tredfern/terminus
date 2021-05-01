-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.calculate", function()
  local Calculate = require "game.rules.field_of_view.calculate"
  local Position = require "game.rules.world.position"

  it("returns visible calculations for tiles around a point when no obstacles are present", function()
    local state = {

    }
    local vm = Calculate(state, Position(5, 5, 1), 4)
    assert.is_true(vm:isVisible(Position(2, 3, 1)))
    assert.is_true(vm:isVisible(Position(3, 2, 1)))
    assert.is_true(vm:isVisible(Position(3, 3, 1)))
    assert.is_true(vm:isVisible(Position(4, 2, 1)))
    assert.is_true(vm:isVisible(Position(5, 5, 1)))
    assert.is_true(vm:isVisible(Position(8, 7, 1)))
    assert.is_true(vm:isVisible(Position(6, 8, 1)))
    assert.is_true(vm:isVisible(Position(7, 4, 1)))


    -- Out of range
    assert.is_false(vm:isVisible(Position(1, 1, 1))) -- d = 5.6
    assert.is_false(vm:isVisible(Position(1, 2, 1))) -- d = 5
    assert.is_false(vm:isVisible(Position(1, 3, 1))) -- d = 4.47
    assert.is_false(vm:isVisible(Position(2, 2, 1))) -- d = 4.2

    -- Different level is not visible
    assert.is_false(vm:isVisible(Position(2, 2, 2)))
  end)
end)