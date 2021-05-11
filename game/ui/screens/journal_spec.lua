-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.journal", function()
  local Journal = require "game.ui.screens.journal"

  it("creates a valid component", function()
    local j = Journal()
    assert.is_table(j)
    assert.equals("journal_screen", j.id)
  end)

  it("closes the journal when j is pushed", function()
    local App = require "game.app"
    spy.on(App, "combat")

    moonpie.testRender(Journal())
    moonpie.keyboard:keyPressed("j")

    assert.spy(App.combat).was.called()
    App.combat:revert()
  end)
end)