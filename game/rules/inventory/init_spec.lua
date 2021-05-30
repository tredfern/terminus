-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory", function()
  local Inventory = require "game.rules.inventory"

  it("has the core components expected", function()
    assert.not_nil(Inventory.actions)
    assert.not_nil(Inventory.reducer)
    assert.not_nil(Inventory.selectors)
  end)
end)