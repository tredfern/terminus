-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.selectors.get_all_with_components", function()
  local getAllWithComponents = require "game.rules.world.selectors.get_all_with_components"

  it("returns any entity from characters, items, or world that has these components", function()
    local e1 = { x = 1, y = 1, image = {} }
    local e2 = { x = 1, y = 1, image = {} }
    local e3 = { x = 1, y = 1 }
    local e4 = { x = 1, y = 1, image = {} }

    local state = {
      characters = { e1 },
      items = { e2, e3 },
      world = {
        e4
      }
    }

    local out = getAllWithComponents(state, "x", "y", "image")
    assert.array_includes(e1, out)
    assert.array_includes(e2, out)
    assert.array_includes(e4, out)
    assert.not_array_includes(e3, out)
  end)
end)