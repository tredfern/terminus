-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.cargo_hold", function()
  local cargo_hold = require "game.ui.widgets.cargo_hold"
  local mock_store = require "mock_store"
  local rendered

  before_each(function()
    mock_store{
      player_cargo = {
        { name = "item a", quantity = 3 },
        { name = "item b", quantity = 10 }
      }
    }
    rendered = moonpie.test_render(cargo_hold())
  end)

  it("displays each item in the cargo hold", function()
    assert.equals("item a", rendered:find_by_id("item a_name").text)
    assert.equals("3", rendered:find_by_id("item a_quantity").text)
    assert.equals("item b", rendered:find_by_id("item b_name").text)
    assert.equals("10", rendered:find_by_id("item b_quantity").text)
  end)

end)