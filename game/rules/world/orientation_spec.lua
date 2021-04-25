-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.orientation", function()
  local orientation = require "game.rules.world.orientation"

  it("has values that can represent various headings", function()
    assert.not_nil(orientation.eastWest) -- for representing either/both
    assert.not_nil(orientation.northSouth) -- for representing either/both
    assert.not_nil(orientation.north)
    assert.not_nil(orientation.south)
    assert.not_nil(orientation.east)
    assert.not_nil(orientation.west)
  end)
end)