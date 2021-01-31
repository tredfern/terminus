-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.panel", function()
  local panel = require "game.ui.widgets.panel"

  it("displays a title for the panel", function()
    local p = panel {
      title = "Some Place"
    }
    assert.equals("Some Place", p:findByID("panel_title").text)
  end)

  it("renders out specified child", function()
    local w = { id = "child_widget" }
    local p = panel {
      title = "A thing",
      contents = w
    }

    assert.equals(w, p:findByID("panel_contents")[1])
  end)
end)