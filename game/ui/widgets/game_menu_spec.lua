-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.game_menu", function()
  local game_menu = require "game.ui.widgets.game_menu"
  local app = require "game.app"


  it("instantiates a component", function()
    assert.not_nil(game_menu())
  end)

  it("shows as a modal", function()
    assert.equals("modal", game_menu().target_layer)
  end)

  it("can redirect to title screen", function()
    local s = spy.on(app, "title")
    local menu = game_menu()
    menu:find_by_id("btn_title_screen"):click()
    assert.spy(s).was_called()
    assert.is_true(menu:needs_removal())
  end)

  it("can exit the game", function()
    local s = spy.on(app, "quit")
    local menu = game_menu()
    menu:find_by_id("btn_quit"):click()
    assert.spy(s).was_called()
  end)

  it("can close the menu", function()
    local menu = game_menu()
    menu:find_by_id("btn_resume"):click()
    assert.is_true(menu:needs_removal())
  end)
end)