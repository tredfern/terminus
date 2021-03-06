-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.selectors.get_by_position", function()
  local getByPosition = require "game.rules.items.selectors.get_by_position"

  it("returns all the items that match a certain position", function()
    local find1 = { x = 12, y = 17 }
    local find2 = { x = 12, y = 17 }
    local skip = { x = 2, y = 7 }

    local state = {
      items = { find1, find2, skip }
    }
    local found = getByPosition(state, 12, 17)

    assert.array_includes(find1, found)
    assert.array_includes(find2, found)
    assert.not_array_includes(skip, found)
  end)
end)