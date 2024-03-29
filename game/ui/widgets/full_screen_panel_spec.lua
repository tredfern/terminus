-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.full_screen_panel", function()
  local fullScreenPanel = require "game.ui.widgets.full_screen_panel"

  it("has a title", function()
    local panel = fullScreenPanel {
      title = "Hello"
    }
    assert.equals("Hello", panel:findByID("full_screen_panel_title_text").text)
  end)

  it("renders any contents out into the panel", function()
    local panel = fullScreenPanel {
      contents = {
        { id = "some-child-component"}
      }
    }

    assert.not_nil(panel:findByID("some-child-component"))
  end)

  it("can take some actions that should be render in the title", function()
    local Components = require "moonpie.ui.components"
    local a1, a2 = Components.button { id = "action1" }, Components.button { id = "action2" }
    local panel = fullScreenPanel {
      actions = { a1, a2 }
    }

    assert.not_nil(panel:findByID("action1"))
    assert.not_nil(panel:findByID("action2"))
  end)
end)