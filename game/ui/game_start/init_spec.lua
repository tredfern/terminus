-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.game_start", function()
  local GameStart = require "game.ui.game_start"

  it("creates a valid component", function()
    local gs = GameStart()
    assert.is_table(gs)
    assert.equals("game_start_screen", gs.id)
  end)

  it("triggers the main screen on close", function()
    local App = require "game.app"
    stub(App, "mainScreen")
    local t = moonpie.testRender(GameStart())
    local btn = t:findByID("btnStart")
    btn:click()
    assert.spy(App.mainScreen).was.called()
    App.mainScreen:revert()
  end)
end)