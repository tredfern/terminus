-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.world_map", function()
  local WorldMap = require "game.ui.screens.world_map"
  local testStates = require "test_helpers.test_states"

  before_each(function()
    testStates.basicGameState()
  end)

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

  it("also closes on m key", function()
    local App = require "game.app"
    spy.on(App, "combat")

    local Moonpie = require "moonpie"
    Moonpie.testRender(WorldMap())

    local Keyboard = require "moonpie.keyboard"
    Keyboard:keyPressed("m")

    assert.spy(App.combat).was.called()
  end)
end)