-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.market", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local cargo_hold = require "game.entities.starship.cargo_hold"
  local trade_good = require "game.entities.trade_good"
  local port_alpha, player_hold, market
  local organics = trade_good:new { name = "organics" }
  local technology = trade_good:new { name = "technology" }

  before_each(function()
    port_alpha = spaceport:new { name = "Alpha" }
    player_hold = cargo_hold:new { size = 15 }
    port_alpha:set_price(organics, 27)
    port_alpha:set_price(technology, 32)

    market = moonpie.ui.components.market { market = port_alpha, cargo_hold = player_hold }
  end)

  it("displays an entry for each item", function()
    assert.equals("organics", market:find_by_id("organics_name").text)
    assert.equals("27", market:find_by_id("organics_price").text)
  end)

  it("has a buy button that transfers cargo to the player hold", function()
    local buy = market:find_by_id("organics_buy")
    buy:click()
    assert.equals(1, player_hold:get_cargo_quantity(organics))
  end)

  it("shows the quantity of items that the player has", function()
    local quantity = market:find_by_id("organics_player_quantity")
    assert.equals("0", quantity.text)

    local buy = market:find_by_id("organics_buy")
    buy:click()

    assert.equals(1, quantity.text)
  end)

  it("has a sell button that transfers cargo back to the market", function()
    player_hold:add_cargo(organics, 10)

    local sell = market:find_by_id("organics_sell")
    sell:click()

    local quantity = market:find_by_id("organics_player_quantity")
    assert.equals(9, quantity.text)
  end)
end)