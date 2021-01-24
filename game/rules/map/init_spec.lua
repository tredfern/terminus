-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map", function()
  local map = require "game.rules.map"

  it("can create a map", function()
    local m = map.create(40, 28)
    assert.equals(40, m.width)
    assert.equals(28, m.height)
  end)

  it("defines actions available", function()
    assert.not_nil(map.actions.types)
    assert.not_nil(map.actions.set)
  end)

  it("defines the selectors available", function()
    assert.not_nil(map.selectors.get_dimensions)
    assert.not_nil(map.selectors.get_rooms)
    assert.not_nil(map.selectors.get_terrain)
  end)

  it("defines map generators", function()
    assert.not_nil(map.generators.dungeon)
  end)
end)