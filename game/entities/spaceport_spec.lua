-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.spaceport", function()
  local spaceport = require "game.entities.spaceport"
  local trade_good = require "game.entities.trade_good"
  local organics = trade_good:new { name = "organics" }
  local technology = trade_good:new { name = "technology" }

  it("has a name", function()
    local s = spaceport:new{ name = "Foo" }
    assert.equals("Foo", s.name)
  end)

  it("can set prices of goods", function()
    local s = spaceport:new{ name = "Alpha" }
    s:set_price(organics, 25)
    s:set_price(technology, 45)

    assert.equals(25, s:get_price(organics))
    assert.equals(45, s:get_price(technology))
  end)

  it("can get a list of goods", function()
    local s = spaceport:new{ name = "Beta" }
    s:set_price(organics, 15)
    s:set_price(technology, 38)
    local goods = s:get_available_goods()
    assert.array_includes_all({
      { trade_good = organics, price = 15 },
      { trade_good = technology, price = 38 } },
    goods, function(test, val) return test.name == val.name and test.price == val.price end)
  end)
end)