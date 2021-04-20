-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.tile_map", function()
  local tileMap = require "game.rules.map.tile_map"
  local Position = require "game.rules.world.position"

  it("can add tiles with terrain and other data", function()
    local t = tileMap:new()
    local terrain, image = {}, {}
    t:updateTile(Position(1, 3, 1), { terrain = terrain, image = image })
    assert.equals(terrain, t:getTile(Position(1, 3, 1)).terrain)
    assert.equals(image, t:getTile(Position(1, 3, 1)).image)
  end)

  it("can update tiles", function()
    local t = tileMap:new()
    local oldTerrain = {}
    local terrain, image = {}, {}
    t:updateTile(Position(1, 3, 1), { terrain = oldTerrain, image = image })
    t:updateTile(Position(1, 3, 1), { terrain = terrain })
    assert.equals(terrain, t:getTile(Position(1, 3, 1)).terrain)
    assert.equals(image, t:getTile(Position(1, 3, 1)).image)
  end)

  it("returns nil if tile has not been set yet", function()
    local t = tileMap:new()
    assert.is_nil(t:getTile(Position(3, 2, 4)))
  end)

  it("returns the largest computed dimensions for the map", function()
    local t = tileMap:new()
    t:updateTile(Position(10, 3, 3), { })
    t:updateTile(Position(1, 30, 58), { })
    assert.equals(10, t.width)
    assert.equals(30, t.height)
    assert.equals(58, t.levels)
  end)

  it("can return the neighbor tiles", function()
    local t = tileMap:new()
    local t1, t2, t3, t4, t5, t6, t7, t8, t9 = {id=1}, {id=2}, {id=3}, {id=4}, {id=5}, {id=6}, {id=7}, {id=8}, {id=9}
    local up, down = {id=11}, {id=12}
    t:updateTile(Position(1, 1, 1), t1)
    t:updateTile(Position(2, 1, 1), t2)
    t:updateTile(Position(3, 1, 1), t3)
    t:updateTile(Position(1, 2, 1), t4)
    t:updateTile(Position(2, 2, 1), t5)
    t:updateTile(Position(3, 2, 1), t6)
    t:updateTile(Position(1, 3, 1), t7)
    t:updateTile(Position(2, 3, 1), t8)
    t:updateTile(Position(3, 3, 1), t9)
    t:updateTile(Position(2, 2, 2), up)
    t:updateTile(Position(2, 2, 0), down)

    local out = t:getNeighbors(Position(2, 2, 1))
    assert.equals(1, out.nw.id)
    assert.equals(2, out.n.id)
    assert.equals(3, out.ne.id)
    assert.equals(4, out.w.id)
    assert.equals(6, out.e.id)
    assert.equals(7, out.sw.id)
    assert.equals(8, out.s.id)
    assert.equals(9, out.se.id)
    assert.equals(11, out.up.id)
    assert.equals(12, out.down.id)
  end)
end)