-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.trade_good", function()
  local trade_good = require "game.entities.trade_good"

  it("has a baseline price point", function()
    local wood = trade_good:new { name = "wood", baseprice = 2 }
    assert.equals(2, wood.baseprice)
  end)
end)