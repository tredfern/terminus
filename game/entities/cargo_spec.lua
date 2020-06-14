-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.cargo", function()
  local cargo = require "game.entities.cargo"

  it("has a name and quantity", function()
    local c = cargo("Some Good", 5)

    assert.equals("Some Good", c.name)
    assert.equals(5, c.quantity)
  end)
end)