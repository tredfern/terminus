-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.selectors.get_all", function()
  local getAll = require "game.rules.items.selectors.get_all"

  it("returns all the items out of the state", function()
    local allTheItems = {}
    local state = { items = allTheItems }

    assert.equals(allTheItems, getAll(state))
  end)
end)