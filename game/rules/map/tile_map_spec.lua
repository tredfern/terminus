-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.tile_map", function()
  local tileMap = require "game.rules.map.tile_map"

  it("can add tiles with terrain and other data", function()
    local t = tileMap:new()
    local terrain, image = {}, {}
    t:updateTile(1, 3, { terrain = terrain, image = image })
    assert.equals(terrain, t:getTile(1, 3).terrain)
    assert.equals(image, t:getTile(1, 3).image)
  end)

  it("can update tiles", function()
    local t = tileMap:new()
    local oldTerrain = {}
    local terrain, image = {}, {}
    t:updateTile(1, 3, { terrain = oldTerrain, image = image })
    t:updateTile(1, 3, { terrain = terrain })
    assert.equals(terrain, t:getTile(1, 3).terrain)
    assert.equals(image, t:getTile(1, 3).image)
  end)

  it("returns nil if tile has not been set yet", function()
  end)

  it("returns the largest computed dimensions for the map", function()
    local t = tileMap:new()
    t:updateTile(10, 3, { })
    t:updateTile(1, 30, { })
    assert.equals(10, t.width)
    assert.equals(30, t.height)
  end)

  it("can return the neighbor tiles", function()
    local t = tileMap:new()
    local t1, t2, t3, t4, t5, t6, t7, t8, t9 = {id=1}, {id=2}, {id=3}, {id=4}, {id=5}, {id=6}, {id=7}, {id=8}, {id=9}
    t:updateTile(1, 1, t1)
    t:updateTile(2, 1, t2)
    t:updateTile(3, 1, t3)
    t:updateTile(1, 2, t4)
    t:updateTile(2, 2, t5)
    t:updateTile(3, 2, t6)
    t:updateTile(1, 3, t7)
    t:updateTile(2, 3, t8)
    t:updateTile(3, 3, t9)

    local out = t:getNeighbors(2, 2)
    assert.equals(1, out.nw.id)
    assert.equals(2, out.n.id)
    assert.equals(3, out.ne.id)
    assert.equals(4, out.w.id)
    assert.equals(6, out.e.id)
    assert.equals(7, out.sw.id)
    assert.equals(8, out.s.id)
    assert.equals(9, out.se.id)
  end)


end)