-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.generators.dungeon", function()
  local map = require "game.rules.map.map"
  local dungeon = require "game.rules.map.generators.dungeon"

  it("can create a node for the tree", function()
    local node = dungeon.create_node(1, 1, 100, 100)
    assert.equals(1, node.x)
    assert.equals(1, node.y)
    assert.equals(100, node.width)
    assert.equals(100, node.height)
  end)

  it("divides a node into 2 sub-nodes on the x-axis", function()
    local node = dungeon.create_node(1, 1, 100, 100)
    dungeon.divide(node, 1, 1)
    assert.equals(1, node.left.x)
    assert.equals(1, node.left.y)
    assert.equals(node.right.x, node.left.x + node.left.width)
    assert.equals(100, node.left.height)


    assert.equals(node.left.x + node.left.width, node.right.x)
    assert.equals(1, node.right.y)
    assert.equals(100 - node.right.x + 1, node.right.width)
    assert.equals(100, node.right.height)
  end)

  it("will divide on y-axis if height is greater than width", function()
    local node = dungeon.create_node(1, 1, 50, 100)
    dungeon.divide(node, 1, 1)
    assert.equals(1, node.left.x)
    assert.equals(1, node.left.y)
    assert.equals(50, node.left.width)
    assert.equals(node.right.y, node.left.y + node.left.height)


    assert.equals(1, node.right.x)
    assert.equals(node.left.y + node.left.height, node.right.y)
    assert.equals(50, node.right.width)
    assert.equals(100 - node.right.y + 1, node.right.height)
  end)

  it("does not divide a node if not at least 6 width and height", function()
    local node = dungeon.create_node(1, 1, 5, 5)
    dungeon.divide(node, 1, 3)
    assert.is_nil(node.left)
    assert.is_nil(node.right)
  end)

  it("subdivides the tree to a certain level", function()
    local node = dungeon.create_node(1, 1, 100, 100)
    dungeon.divide(node, 1, 4)

    assert.not_nil(node.left.left.left)
  end)

  it("builds a room within the boundaries of the node", function()
    local node = dungeon.create_node(15, 18, 23, 27)
    dungeon.create_rooms(node)

    assert.not_nil(node.room)
    assert.is_true(node.room.x >= node.x)
    assert.is_true(node.room.y >= node.y)
    assert.is_true(node.room.width <= node.width)
    assert.is_true(node.room.height <= node.height)

    assert.is_true(node.room.x + node.room.width <= node.x + node.width)
    assert.is_true(node.room.y + node.room.height <= node.y + node.height)
  end)

  it("adds the rooms to the map after generation", function()
    local m = map:new { width = 50, height = 50 }
    assert.is_true(#m.rooms > 0)
  end)
end)