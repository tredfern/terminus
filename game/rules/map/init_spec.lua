-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map", function()
  local Map = require "game.rules.map"

  it("can create a map", function()
    local m = Map.create(40, 28)
    assert.equals(40, m.width)
    assert.equals(28, m.height)
  end)

  it("defines actions available", function()
    assert.not_nil(Map.actions.types)
    assert.not_nil(Map.actions.set)
  end)

  it("defines the selectors available", function()
    assert.not_nil(Map.selectors.getDimensions)
    assert.not_nil(Map.selectors.getNeighborTerrain)
    assert.not_nil(Map.selectors.getRooms)
    assert.not_nil(Map.selectors.getTerrain)
  end)

  it("defines map generators", function()
    assert.not_nil(Map.generators.dungeon)
  end)
end)