-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.selectors.get_visible_positions", function()
  local getVisiblePositions = require "game.rules.field_of_view.selectors.get_visible_positions"
  local visibilityMap = require "game.rules.field_of_view.visibility_map"
  local Position = require "game.rules.world.position"

  it("returns a list of all positions that are visible to the current entity", function()
    local vm = visibilityMap:new()
    vm:setVisible(Position(1, 3, 2))
    vm:setVisible(Position(1, 3, 3))
    vm:setVisible(Position(1, 2, 2))
    vm:setVisible(Position(2, 4, 2))
    vm:setVisible(Position(3, 3, 2))

    local entity = {}
    local state = {
      fieldOfView = {
        [entity] = vm
      }
    }

    local result = getVisiblePositions(state, entity)

    local tables = require "moonpie.tables"
    assert.equals(5, #result)
    assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 3, 2 }) end))
    assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 3, 3 }) end))
    assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 2, 2 }) end))
    assert.is_true(tables.any(result, function(p) return Position.equal(p, { 2, 4, 2 }) end))
    assert.is_true(tables.any(result, function(p) return Position.equal(p, { 3, 3, 2 }) end))
  end)
end)