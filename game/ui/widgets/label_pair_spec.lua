-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.label_pair", function()
  local labelPair = require "game.ui.widgets.label_pair"

  it("takes a label and value and makes text components for them", function()
    local component = labelPair {
      label = "Testing:",
      value = "123"
    }

    assert.equals("Testing:", component:findByID("Label").text)
    assert.equals("123", component:findByID("Value").text)
  end)

  it("combines id into child components", function()
    local component = labelPair {
      id = "somePair", label = "somePair", value = "Food"
    }
    assert.not_nil(component:findByID("somePairLabel"))
    assert.not_nil(component:findByID("somePairValue"))
  end)
end)