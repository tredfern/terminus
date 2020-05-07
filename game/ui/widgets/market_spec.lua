-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.market", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local cargo_hold = require "game.entities.starship.cargo_hold"
  local port_alpha, player_hold, market

  before_each(function()
    port_alpha = spaceport:new { name = "Alpha" }
    player_hold = cargo_hold:new { size = 15 }
    port_alpha:set_price("item_a", 27)
    port_alpha:set_price("item_b", 32)
    port_alpha:set_price("item_c", 45)

    market = moonpie.ui.components.market { market = port_alpha, cargo_hold = player_hold }
  end)

  it("displays an entry for each item", function()
    assert.equals("item_a", market:find_by_id("item_a_name").text)
    assert.equals("27", market:find_by_id("item_a_price").text)
  end)

  it("displays the current cargo for each good", function()
    assert.equals("0", market:find_by_id("item_a_player_quantity").text)
  end)

  it("has a buy button that transfers cargo to the player hold", function()
    local buy = market:find_by_id("item_a_buy")
    buy:click()
    assert.equals(1, player_hold:get_cargo_quantity("item_a"))
  end)

end)