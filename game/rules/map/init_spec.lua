-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map", function()
  local Map = require "game.rules.map"

  it("defines actions available", function()
    assert.not_nil(Map.actions.types)
    assert.not_nil(Map.actions.add)
    assert.not_nil(Map.actions.create)
  end)

  it("defines the selectors available", function()
    assert.not_nil(Map.selectors.getDimensions)
    assert.not_nil(Map.selectors.getRooms)
    assert.not_nil(Map.selectors.getTerrain)
    assert.not_nil(Map.selectors.getTile)
  end)

  it("defines map generators", function()
    assert.not_nil(Map.generators.dungeon)
  end)
end)