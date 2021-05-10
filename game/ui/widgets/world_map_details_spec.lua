-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.world_map_details", function()
  local WorldMapDetails = require "game.ui.widgets.world_map_details"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Position = require "game.rules.world.position"

  before_each(function()
    mockStore {
      characters = { { isPlayerControlled = true, position = Position(1, 3, 2) } },
      map = { outline = { width = 100, height = 100, levels = 4 }}
    }
  end)

  it("renders a table and id", function()
    local wm = WorldMapDetails()
    assert.is_table(wm)
    assert.equals("world_map_details", wm.id)
  end)

  it("starts with the current level of the player", function()
    local wm = WorldMapDetails()
    moonpie.testRender(wm)
    assert.equals(2, wm.currentLevel)
    assert.not_nil(wm.player)
  end)

  it("can adjust the viewed level with the ',' and '.' keys", function()
    local wm = WorldMapDetails()
    moonpie.testRender(wm)

    local Keyboard = require "moonpie.keyboard"

    Keyboard:keyPressed(",")
    Keyboard:keyPressed(",")
    Keyboard:keyPressed(",")
    assert.equals(1, wm.currentLevel)
    Keyboard:keyPressed(".")
    assert.equals(2, wm.currentLevel)
    Keyboard:keyPressed(".")
    assert.equals(3, wm.currentLevel)
    Keyboard:keyPressed(".")
    assert.equals(4, wm.currentLevel)
    -- Caps out at top level
    Keyboard:keyPressed(".")
    Keyboard:keyPressed(".")
    assert.equals(4, wm.currentLevel)
  end)

end)