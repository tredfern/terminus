-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.location_title", function()
  local title = require "game.ui.widgets.location_title"
  local mock_store = require "mock_store"

  it("renders the name of the current location", function()
    mock_store({ location = { name = "Foo" } })
    local t = title()
    local render = moonpie.test_render(t)
    assert.equals("Foo", render:find_by_id("location_title_label").text)
  end)

end)