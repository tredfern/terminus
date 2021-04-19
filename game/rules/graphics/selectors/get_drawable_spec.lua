-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.selectors.get_drawable", function()
  local getDrawable = require "game.rules.graphics.selectors.get_drawable"

  it("returns components with a sprite and position", function()
    local state = {
      world = {
        { sprite = {}, position = {} },
        { sprite = {}, position = {} },
        { sprite = {}, position = {} },
        { sprite = {} },
        { position = {} }
      }
    }

    local result = getDrawable(state)
    assert.equals(3, #result)
  end)
end)