-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.starship.cargo_hold", function()
  local cargo_hold = require "game.entities.starship.cargo_hold"
  local trade_good = require "game.entities.trade_good"
  local food = trade_good:new { name = "food" }
  local dirt = trade_good:new { name = "dirt" }

  it("is has set amount of space", function()
    local cg = cargo_hold:new { size = 25 }
    assert.equals(25, cg.size)
  end)

  it("can have trade_goods added to it", function()
    local cg = cargo_hold:new { size = 32 }
    cg:add_cargo(food, 10)
    assert.equals(10, cg:get_cargo_quantity(food))
  end)

  it("increments cargo when adding twice in a row", function()
    local cg = cargo_hold:new { size = 25 }
    cg:add_cargo(food, 10)
    cg:add_cargo(food, 5)
    assert.equals(15, cg:get_cargo_quantity(food))
  end)

  it("returns zero if it the cargo hasn't been referenced before", function()
    local cg = cargo_hold:new { size = 15 }
    assert.equals(0, cg:get_cargo_quantity(food))
  end)

  it("can get the capacity available based on cargo in storage", function()
    local cg = cargo_hold:new { size = 15 }
    assert.equals(15, cg:free_space())
    cg:add_cargo(food, 7)
    assert.equals(8, cg:free_space())
    cg:add_cargo(dirt, 7)
    assert.equals(1, cg:free_space())
  end)

  it("can remove cargo from the hold", function()
    local cg = cargo_hold:new { size = 15 }
    cg:add_cargo(food, 5)
    assert.equals(5, cg:get_cargo_quantity(food))
    cg:remove_cargo(food, 2)
    assert.equals(3, cg:get_cargo_quantity(food))
  end)
end)