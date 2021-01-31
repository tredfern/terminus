-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


describe("game.ui.screens.title", function()
  local title = require "game.ui.screens.title"

  it("instantiates a component", function()
    assert.not_nil(title())
  end)

  it("triggers new game on the app if new game is clicked", function()
    local app = require "game.app"
    mock(app, "newGame")

    -- instantiate the title component to test it
    local component = title()
    component:findByID("newGame_button"):click()
    assert.spy(app.newGame).was.called()
  end)
end)