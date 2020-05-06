-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.spaceport", function()
  local spaceport = require "game.entities.spaceport"

  it("has a name", function()
    local s = spaceport:new{ name = "Foo" }
    assert.equals("Foo", s.name)
  end)

  it("can set prices of goods", function()
    local s = spaceport:new{ name = "Alpha" }
    s:set_price("organic", 25)
    s:set_price("technology", 45)

    assert.equals(45, s:get_price("technology"))
    assert.equals(25, s:get_price("organic"))
  end)

  it("can get a list of goods", function()
    local s = spaceport:new{ name = "Beta" }
    s:set_price("organice", 15)
    s:set_price("tech", 38)
    local goods = s:get_available_goods()
    assert.array_includes_all({
      { name = "organice", price = 15 },
      { name = "tech", price = 38 } },
    goods, function(test, val) return test.name == val.name and test.price == val.price end)
  end)
end)