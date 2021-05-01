-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.helper", function()
  local Helper = require "game.rules.field_of_view.helper"
  local Position = require "game.rules.world.position"

  it("returns false if nothing blocks visibility", function()
    local state = {}
    assert.is_false(Helper.blocksSight(state, Position(1, 4, 2)))
  end)

  it("returns true if position has terrain that blocks visibility", function()
    local Map = require "game.rules.map"
    local old = Map.selectors.getTerrain
    Map.selectors.getTerrain = spy.new(function() return { blocksSight = true } end)

    assert.is_true(Helper.blocksSight({}, Position(1, 3, 2)))
    Map.selectors.getTerrain = old
  end)

  it("returns true if there is an entity at a position that blocks sight", function()
    local World = require "game.rules.world"
    local old = World.selectors.getByPosition
    World.selectors.getByPosition = spy.new(function() return { { blocksSight = true } } end)

    assert.is_true(Helper.blocksSight({}, Position, 1, 3, 2))
    World.selectors.getByPosition = old

  end)
end)