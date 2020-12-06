-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.app", function()
  -- App is the central glue module that loads up the modules and links things together
  local app = require "game.app"

  it("can render scenes", function()
    app.render({ id = "foo" })
    assert.not_nil(moonpie.ui.current.find_by_id("foo"))
  end)

  describe("starting a new game", function()
    it("can start a new game", function()
      assert.has_no_errors(function() app.new_game() end)
    end)

    it("renders the combat screen", function()
      app.new_game()
      assert.not_nil(moonpie.ui.current.find_by_id("combat_screen"))
    end)
  end)
end)