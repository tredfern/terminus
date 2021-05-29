-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.splash", function()
  local Splash = require "game.ui.splash"

  it("renders a component", function()
    local splash = Splash()
    assert.is_table(splash)
    assert.equals("splash_screen", splash.id)
  end)

  it("automatically advances to title screen after a couple of seconds", function()
  end)

  it("advances to title screen if any key is pressed", function()
    local App = require "game.app"
    spy.on(App, "title")

    local Moonpie = require "moonpie"
    Moonpie.testRender(Splash())

    local Keyboard = require "moonpie.keyboard"
    Keyboard:keyPressed("t")

    assert.spy(App.title).was.called()
  end)

  it("advances to title screen on click", function()
    local App = require "game.app"
    spy.on(App, "title")

    local splash = Splash()
    splash:click()

    assert.spy(App.title).was.called()
  end)
end)