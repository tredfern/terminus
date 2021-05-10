-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


describe("game.ui.screens.title", function()
  local title = require "game.ui.screens.title"
  local app = require "game.app"

  it("instantiates a component", function()
    assert.not_nil(title())
  end)

  it("triggers new game on the app if new game is clicked", function()
    mock(app, "newGame")

    -- instantiate the title component to test it
    local component = title()
    component:findByID("newGame_button"):click()
    assert.spy(app.newGame).was.called()
  end)

  it("triggers the options screen if options is clicked", function()
    mock(app, "options")
    local screen = title()
    screen:findByID("options_button"):click()
    assert.spy(app.options).was.called_with(app.title)
  end)

  it("can continue the previously saved game", function()
    mock(app, "continue")
    local screen = title()
    screen:findByID("btnContinue"):click()
    assert.spy(app.continue).was.called()
  end)

  it("can show the statistics for the player", function()
    spy.on(app, "achievements")
    local screen = title()
    screen:findByID("btnAchievements"):click()
    assert.spy(app.achievements).was.called()
  end)
end)