-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.cargo_update", function()
  local cargo_update = require "game.rules.actions.cargo_update"
  local types = require "game.rules.actions.types"

  it("provides the name and amount of cargo", function()
    local c = cargo_update("Gadgets", 18)
    assert.equals(types.cargo_update, c.type)
    assert.equals("Gadgets", c.payload.name)
    assert.equals(18, c.payload.quantity)
  end)
end)