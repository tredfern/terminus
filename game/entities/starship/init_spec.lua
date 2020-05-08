-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.starship", function()
  local starship = require "game.entities.starship"
  local cargo_hold = require "game.entities.starship.cargo_hold"


  it("can initialize with a cargo hold", function()
    local cg = cargo_hold:new{ size = 15 }
    local s = starship.new { cargo_hold = cg }
    assert.equals(s.cargo_hold, cg)
  end)
end)