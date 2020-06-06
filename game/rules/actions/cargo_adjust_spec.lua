-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.cargo_adjust", function()
  local cargo_adjust = require "game.rules.actions.cargo_adjust"
  local types = require "game.rules.actions.types"

  it("specifies the correct type", function()
    local ca = cargo_adjust("food", 5)
    assert.equals(types.cargo_adjust, ca.type)
  end)

  it("specifies the cargo name", function()
    local ca = cargo_adjust("computers", 8)
    assert.equals("computers", ca.payload.name)
  end)

  it("specifies how much to add or remove", function()
    local ca = cargo_adjust("computer", -7)
    assert.equals(-7, ca.payload.amount)
  end)
end)