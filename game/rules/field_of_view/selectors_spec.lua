-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.selectors", function()
  local Selectors = require "game.rules.field_of_view.selectors"

  describe("SELECTOR: get", function()
    it("retrieves a specific field of view from state", function()
      local entity, fov = {}, {}
      local state = {
        fieldOfView = {
          [entity] = fov
        }
      }

      assert.equals(fov, Selectors.get(state, entity))
    end)

    it("return nil if no field of view state is available", function()
      assert.is_nil(Selectors.get({}, {}))
    end)
  end)

  describe("SELECTOR: getVisiblePositions", function()
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

      local result = Selectors.getVisiblePositions(state, entity)

      local tables = require "moonpie.tables"
      assert.equals(5, #result)
      assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 3, 2 }) end))
      assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 3, 3 }) end))
      assert.is_true(tables.any(result, function(p) return Position.equal(p, { 1, 2, 2 }) end))
      assert.is_true(tables.any(result, function(p) return Position.equal(p, { 2, 4, 2 }) end))
      assert.is_true(tables.any(result, function(p) return Position.equal(p, { 3, 3, 2 }) end))
    end)
  end)
end)