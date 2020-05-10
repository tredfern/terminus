-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.cargo_hold", function()
  require "game.ui"
  local starship = require "game.entities.starship"
  local cargo_hold = require "game.entities.starship.cargo_hold"
  local trade_good = require "game.entities.trade_good"
  local player

  before_each(function()
    player = starship:new{ cargo_hold = cargo_hold:new { size = 25 } }
    player.cargo_hold:add_cargo(trade_good:new { name = "item a" }, 3)
    player.cargo_hold:add_cargo(trade_good:new { name = "item b" }, 5)
  end)

  it("displays each item in the cargo hold", function()
    local cargo_display = moonpie.ui.components.cargo_hold { player = player }
    local rendered = moonpie.test_render(cargo_display)

    assert.equals("item a", rendered:find_by_id("item a_name").text)
    assert.equals("3", rendered:find_by_id("item a_quantity").text)
    assert.equals("item b", rendered:find_by_id("item b_name").text)
    assert.equals("5", rendered:find_by_id("item b_quantity").text)
  end)

  it("updates the component when changed", function()
    local cargo_display = moonpie.ui.components.cargo_hold { player = player }
    local rendered = moonpie.test_render(cargo_display)
    player.cargo_hold:add_cargo(trade_good:new { name = "item c" }, 6)
    cargo_display:update{ player = player }
    moonpie.update()
    assert.equals("item c", rendered:find_by_id("item c_name").text)
    assert.equals("6", rendered:find_by_id("item c_quantity").text)
  end)
end)