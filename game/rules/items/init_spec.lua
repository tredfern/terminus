-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items", function()
  local items = require "game.rules.items"

  it("can describe a new item", function()
    items.describe {
      name = "Short sword",
      key = "shortsword"
    }

    assert.equals("Short sword", items.list.shortsword.name)
  end)

  it("add some test items to the game", function()
    assert.not_nil(items.list.sword)
    assert.not_nil(items.list.healthPack)
    assert.not_nil(items.list.keycard)
  end)
end)