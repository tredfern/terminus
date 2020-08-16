-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.container", function()
  local container = require "game.ui.widgets.container"

  it("instantiates a component", function()
    assert.not_nil(container())
  end)

  it("takes any indexed components and makes them children", function()
    local child = { id = "foo" }
    local c = container {
      child
    }

    assert.equals(child, c:find_by_id("foo"))
  end)
end)