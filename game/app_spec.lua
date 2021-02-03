-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  -- App is the central glue module that loads up the modules and links things together
  local app = require "game.app"

  it("can render scenes", function()
    app.render({ id = "foo" })
    assert.not_nil(moonpie.ui.current.findByID("foo"))
  end)

  describe("starting a new game", function()
    it("can start a new game", function()
      assert.has_no_errors(function() app.newGame() end)
    end)

    it("renders the create character screen", function()
      app.newGame()
      assert.not_nil(moonpie.ui.current.findByID("create_character_screen"))
    end)
  end)

  describe("combat screen", function()
    it("renders the combat screen", function()
      app.combat()
      assert.not_nil(moonpie.ui.current.findByID("combat_screen"))
    end)
  end)

  it("can show an option screen with the right return screen", function()
    local returnScreen = function() end
    app.options(returnScreen)
    assert.not_nil(moonpie.ui.current.findByID("options_screen"))
    assert.equals(returnScreen, moonpie.ui.current.findByID("btnClose").click)
  end)
end)