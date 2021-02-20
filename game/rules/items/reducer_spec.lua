-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.reducer", function()
  local reducer = require "game.rules.items.reducer"
  local types = require "game.rules.items.actions.types"

  it("can add items to the state", function()
    local item = {}
    local state = reducer({}, {
      type = types.items_add,
      payload = {
        item = item
      }
    })

    assert.array_includes(item, state)
  end)

  it("can remove an item from state", function()
    local item = {}
    local state = reducer({ item }, {
      type = types.remove,
      payload = {
        item = item
      }
    })

    assert.not_array_includes(item, state)
  end)
end)