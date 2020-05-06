-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.market", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local port_alpha = spaceport:new { name = "Alpha" }


  before_each(function()
    port_alpha:set_price("item_a", 27)
    port_alpha:set_price("item_b", 32)
    port_alpha:set_price("item_c", 45)
  end)

  it("displays an entry for each item", function()
    local market = moonpie.ui.components.market { market = port_alpha }
    assert.equals("item_a", market:find_by_id("item_a_name").text)
    assert.equals("27", market:find_by_id("item_a_price").text)
  end)

end)