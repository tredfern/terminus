-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.visibility_map", function()
  local VisibilityMap = require "game.rules.field_of_view.visibility_map"
  local Position = require "game.rules.world.position"

  it("can specify whether a position is visible", function()
    local vm = VisibilityMap:new()
    vm:setVisible(Position(1, 3, 2))
    vm:setVisible(Position(2, 3, 2))
    vm:setVisible(Position(2, 5, 2))
    assert.is_true(vm:isVisible(Position(1, 3, 2)))
    assert.is_true(vm:isVisible(Position(2, 3, 2)))
    assert.is_true(vm:isVisible(Position(2, 5, 2)))
    assert.is_false(vm:isVisible(Position(3, 5, 2)))
  end)
end)