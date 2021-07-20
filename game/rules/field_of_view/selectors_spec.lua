-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.selectors", function()
  local Selectors = require "game.rules.field_of_view.selectors"
  local Position = require "game.rules.world.position"

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

  describe("SELECTOR: blocksSight", function()
    it("returns false if nothing blocks visibility", function()
      local state = {}
      assert.is_false(Selectors.blocksSight(state, Position(1, 4, 2)))
    end)

    it("returns true if position has terrain that blocks visibility", function()
      local Map = require "game.rules.map"
      local old = Map.selectors.getTerrain
      Map.selectors.getTerrain = spy.new(function() return { blocksSight = true } end)

      assert.is_true(Selectors.blocksSight({}, Position(1, 3, 2)))
      Map.selectors.getTerrain = old
    end)

    it("returns true if there is an entity at a position that blocks sight", function()
      local World = require "game.rules.world"
      local old = World.selectors.getByPosition
      World.selectors.getByPosition = spy.new(function() return { { blocksSight = true } } end)

      assert.is_true(Selectors.blocksSight({}, Position, 1, 3, 2))
      World.selectors.getByPosition = old
    end)
  end)

  describe("SELECTOR: checkLineOfSight", function()
    it("returns true if nothing blocks sight in line between two points", function()
      local state = {
        map = {
          tiles = {
            [Position(1,1,1)] = { terrain = { blocksSight = false } },
            [Position(1,2,1)] = { terrain = { blocksSight = false } },
            [Position(1,3,1)] = { terrain = { blocksSight = false } },
          }
        }
      }
      assert.is_true(Selectors.checkLineOfSight(state, Position(1, 1, 1), Position(1, 3, 1)))
    end)

    it("returns false if something blocks the line of sight", function()
      local state = {
        map = {
          tiles = {
            [Position(1,1,1)] = { terrain = { blocksSight = false } },
            [Position(1,2,1)] = { terrain = { blocksSight = true } },
            [Position(1,1,1)] = { terrain = { blocksSight = false } },
          }
        }
      }
      assert.is_false(Selectors.checkLineOfSight(state, Position(1, 1, 1), Position(1, 3, 1)))
    end)
  end)
end)