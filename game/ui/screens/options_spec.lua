-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.options", function()
  local options = require "game.ui.screens.options"

  it("creates a component for the screen", function()
    assert.is_table(options())
  end)

  it("takes a parameter to point what screen to return to", function()
    local backScreen = spy.new(function() end)

    local screen = options({ returnScreen = backScreen })
    screen:findByID("close_button"):click()
    assert.spy(backScreen).was.called()
  end)
end)