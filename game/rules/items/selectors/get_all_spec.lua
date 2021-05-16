-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.selectors.get_all", function()
  local getAll = require "game.rules.items.selectors.get_all"

  it("returns all the items out of the state", function()
    local i1 = { item = true }
    local i2 = { item = true }
    local i3 = { item = true }
    local state = { items = { i1, i2 }, world = { i3 } }

    assert.array_includes(i1, getAll(state))
    assert.array_includes(i2, getAll(state))
    assert.array_includes(i3, getAll(state))
  end)
end)