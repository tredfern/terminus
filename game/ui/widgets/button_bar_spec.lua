-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.button_bar", function()
  local ButtonBar = require "game.ui.widgets.button_bar"
  local Components = require "moonpie.ui.components"

  it("takes a list buttons to build into a toolbar", function()
    local comp = ButtonBar {
      buttons = {
        Components.button { id = "button1" },
        Components.button { id = "button2" }
      }
    }

    assert.not_nil(comp:findByID("button1"))
    assert.not_nil(comp:findByID("button2"))
  end)

  it("does not error if no buttons are set", function()
    assert.has_no_errors(function() ButtonBar {} end)
  end)
end)