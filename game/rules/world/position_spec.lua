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

  it("can create a position shorthand", function()
    local p = Position(1, 5, 3)
    assert.equals(1, p.x)
    assert.equals(5, p.y)
    assert.equals(3, p.z)
  end)

  it("can return relative positions", function()
    local p = Position(1, 5, 3)
    local nw = Position.northwest(p)
    local n = Position.north(p)
    local ne = Position.northeast(p)
    local w = Position.west(p)
    local e = Position.east(p)
    local sw = Position.southwest(p)
    local s = Position.south(p)
    local se = Position.southeast(p)
    local up = Position.up(p)
    local down = Position.down(p)

    assert.is_true(Position.equal(nw, {0, 4, 3}))
    assert.is_true(Position.equal(n,  {1, 4, 3}))
    assert.is_true(Position.equal(ne, {2, 4, 3}))
    assert.is_true(Position.equal(w,  {0, 5, 3}))
    assert.is_true(Position.equal(e,  {2, 5, 3}))
    assert.is_true(Position.equal(sw, {0, 6, 3}))
    assert.is_true(Position.equal(s,  {1, 6, 3}))
    assert.is_true(Position.equal(se, {2, 6, 3}))
    assert.is_true(Position.equal(up, {1, 5, 4}))
    assert.is_true(Position.equal(down, {1, 5, 2}))
  end)
end)