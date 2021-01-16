-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.terrain", function()
  local terrain = require "game.rules.map.terrain"

  it("has a grass terrain", function()
    assert.not_nil(terrain.grass)
    assert.not_nil(terrain.grass.color)
  end)

  it("has a water terrain", function()
    assert.not_nil(terrain.water)
    assert.not_nil(terrain.water.color)
  end)

  it("has a dirt terrain", function()
    assert.not_nil(terrain.dirt)
    assert.not_nil(terrain.dirt.color)
  end)
end)