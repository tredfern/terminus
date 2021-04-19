-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.position", function()
  local Position = require "game.rules.world.position"

  it("can create a position table based on a map, x, y, z coordinates", function()
    local p = Position.new(5, 2, 4)
    assert.equals(5, p.x)
    assert.equals(2, p.y)
    assert.equals(4, p.z)
  end)

  it("can compare two positions together to see if the match", function()
    local p1 = Position.new(1, 1, 1)
    local p2 = Position.new(1, 1, 1)
    local p3 = Position.new(4, 1, 1)
    local p4 = Position.new(1, 1, 3)

    assert.is_true(Position.equal(p1, p2))
    assert.is_false(Position.equal(p1, p3))
    assert.is_false(Position.equal(p2, p4))
  end)

  it("can compare to a simple array to assess values", function()
    local p = Position.new(1, 4, 5)
    assert.is_true(Position.equal(p, { 1, 4, 5 }))
  end)

  it("works with only 2d coordinates as well", function()
    local p = Position.new(1, 5)
    assert.is_true(Position.equal(p,  { 1, 5 }))
  end)
end)