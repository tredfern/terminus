-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.terrain", function()
  local terrain = require "game.rules.map.terrain"

  it("can describe terrain", function()
    terrain.describe { key = "newRoom", blocksMovement = false }
    assert.not_nil(terrain.list.newRoom)
    assert.is_false(terrain.list.newRoom.blocksMovement)
  end)

  it("has a blank and impassable terrain", function()
    assert.not_nil(terrain.list.blank)
    assert.is_true(terrain.list.blank.blocksMovement)
  end)
end)