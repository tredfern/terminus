-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.selectors.has_item_of_kind", function()
  local hasItemOfKind = require "game.rules.player.selectors.has_item_of_kind"

  it("returns true if player inventory has an item of a matching key", function()
    local player = { isPlayerControlled = true, inventory = { { item = { key = "A" } }, { item = { key = "B" } } } }
    local state = { characters = { player } }

    assert.is_true(hasItemOfKind(state, "A"))
    assert.is_true(hasItemOfKind(state, "B"))
    assert.is_false(hasItemOfKind(state, "C"))
  end)
end)