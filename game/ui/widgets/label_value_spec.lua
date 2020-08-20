-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.label_value", function()
  local label_value = require "game.ui.widgets.label_value"

  it("takes a label and value and renders components for each", function()
    local out = label_value { label = "Name", value = "Steve" }
    assert.equals("Name", out:find_by_id("label").text)
    assert.equals("Steve", out:find_by_id("value").text)
  end)

  it("provides helpers to access the label and the value", function()
    local out = label_value { label = "Name", value = "Sharon" }
    assert.equals("Name", out:label())
    assert.equals("Sharon", out:value())
  end)
end)