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

  it("can add or adjust the coordinates for the position", function()
    local p = Position(1, 4, 2)

    local p2 = Position.add(p, {1, 4})
    assert.equals(2, p2.x)
    assert.equals(8, p2.y)
    assert.equals(2, p2.z)

    local p3 = Position.add(p, { 1, 1, 1 })
    assert.equals(2, p3.x)
    assert.equals(5, p3.y)
    assert.equals(3, p3.z)
  end)

  it("can calculate the distance between two points on the same level", function()
    local p = Position(1, 5, 3)
    local p2 = Position(4, 4, 3)

    assert.near(3.16228, Position.distance(p, p2), 2)
  end)

  it("is a readonly table", function()
    local p = Position(3, 2, 4)

    assert.has_errors(function() p.x = p.x + 3 end)
  end)

  describe("hashing", function()
    it("creates the same hash each time", function()
      local p = Position(32, 12, 3)
      local p2 = Position(32, 12, 3)
      assert.not_nil(p.hashKey)
      assert.equals(p.hashKey, p2.hashKey)
    end)

    it("doesn't collide for the first 200x200x50", function()
      pending("Ignore this test, just use it for testing for hash-collisions manually")
      local p = {}
      for x = 1,200 do
        for y = 1,200 do
          for z= 1,50 do
            local l = Position(x, y, z)
            assert.is_nil(p[l.hashKey])
            p[l.hashKey] = l
          end
        end
      end
    end)

    it("can reverse lookup hashkeys", function()
      local p = Position(3, 2, 4)

      local p2 = Position.fromKey(p.hashKey)
      assert.equals(p, p2)
    end)
  end)

  it("can pick a random position in a room", function()
    local room = {
      x = 10, y = 23, width = 14, height = 8, level = 3
    }

    local p = Position.randomInRoom(room)
    assert.is_true(p.x >= 10 and p.x < 24)
    assert.is_true(p.y >= 23 and p.x < 31)
    assert.equals(3, p.z)
  end)

  it("can serialize out a nice string", function()
    assert.equals("Pos(1, 2, 3)", tostring(Position(1, 2, 3)))
  end)

  describe("box iterator", function()
    it("can loop through all the points between two points", function()
      local loop = Position.box(Position(1, 1, 1), Position(2, 2, 2))
      assert.equals(Position(1, 1, 1), loop())
      assert.equals(Position(2, 1, 1), loop())
      assert.equals(Position(1, 2, 1), loop())
      assert.equals(Position(2, 2, 1), loop())
      assert.equals(Position(1, 1, 2), loop())
      assert.equals(Position(2, 1, 2), loop())
      assert.equals(Position(1, 2, 2), loop())
      assert.equals(Position(2, 2, 2), loop())
      assert.is_nil(loop())
    end)

    it("can loop in the reverse direction if necessary", function()
      local loop = Position.box(Position(2, 2, 2), Position(1, 1, 1))
      assert.equals(Position(2, 2, 2), loop())
      assert.equals(Position(1, 2, 2), loop())
      assert.equals(Position(2, 1, 2), loop())
      assert.equals(Position(1, 1, 2), loop())
      assert.equals(Position(2, 2, 1), loop())
      assert.equals(Position(1, 2, 1), loop())
      assert.equals(Position(2, 1, 1), loop())
      assert.equals(Position(1, 1, 1), loop())
      assert.is_nil(loop())
    end)
  end)

  it("creates a unique list of positions in an area", function()
    local tables = require "moonpie.tables"
    local list = Position.createUniqueList(Position(1, 1, 1), Position(5, 5, 5), 20)

    assert.equals(20, #list)
    for _, v in ipairs(list) do
      assert.in_range(1, 5, v.x)
      assert.in_range(1, 5, v.y)
      assert.in_range(1, 5, v.z)
      assert.is_false(tables.any(list, function(p) return p ~= v and p.x == v.x and p.y == v.y and p.z == v.z end))
    end
  end)

  describe("line iterator", function()
    it("can create a line on the same level", function()
      local iter = Position.line(Position(1, 1, 1), Position(10, 3, 1))

      assert.equals(Position(1, 1, 1), iter())
      assert.equals(Position(2, 1, 1), iter())
      assert.equals(Position(3, 1, 1), iter())
      assert.equals(Position(4, 2, 1), iter())
      assert.equals(Position(5, 2, 1), iter())
      assert.equals(Position(6, 2, 1), iter())
      assert.equals(Position(7, 2, 1), iter())
      assert.equals(Position(8, 3, 1), iter())
      assert.equals(Position(9, 3, 1), iter())
      assert.equals(Position(10, 3, 1), iter())
      assert.is_nil(iter())
    end)

    it("cannot create a line between 3 dimensions", function()
      -- not implement yet, will sometime
      assert.has_errors(function() Position.line(Position(1, 1, 1), Position(1, 3, 4)) end)
    end)
  end)

end)