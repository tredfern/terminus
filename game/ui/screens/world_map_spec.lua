-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.world_map", function()
  local WorldMap = require "game.ui.screens.world_map"

  it("creates a table", function()
    local wm = WorldMap()
    assert.is_table(wm)
    assert.equals("world_map", wm.id)
  end)

  it("returns to the main screen if the tab key is pushed", function()
    local App = require "game.app"
    spy.on(App, "combat")

    local Moonpie = require "moonpie"
    Moonpie.testRender(WorldMap())

    local Keyboard = require "moonpie.keyboard"
    Keyboard:keyPressed("tab")
    
    assert.spy(App.combat).was.called()
  end)
end)