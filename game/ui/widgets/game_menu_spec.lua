-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.game_menu", function()
  local gameMenu = require "game.ui.widgets.game_menu"
  local app = require "game.app"


  it("instantiates a component", function()
    assert.not_nil(gameMenu())
  end)

  it("shows as a modal", function()
    assert.equals("modal", gameMenu().target_layer)
  end)

  it("can redirect to title screen", function()
    local s = spy.on(app, "title")
    local menu = gameMenu()
    menu:findByID("btn_title_screen"):click()
    assert.spy(s).was_called()
    assert.is_true(menu:needsRemoval())
  end)

  it("can exit the game", function()
    local s = spy.on(app, "quit")
    local menu = gameMenu()
    menu:findByID("btn_quit"):click()
    assert.spy(s).was_called()
  end)

  it("can close the menu", function()
    local menu = gameMenu()
    menu:findByID("btn_resume"):click()
    assert.is_true(menu:needsRemoval())
  end)

  it("can show the options screen", function()
    spy.on(app, "options")
    local menu = gameMenu()
    menu:findByID("btnOptions"):click()
    assert.spy(app.options).was.called_with(app.mainScreen)
    assert.is_true(menu:needsRemoval())
  end)

  it("can save the game", function()
    spy.on(app, "saveGame")
    local menu = gameMenu()
    menu:findByID("btnSaveGame"):click()
    assert.spy(app.saveGame).was.called()
  end)
end)