-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_enemies", function()
  local get_enemies = require "game.rules.character.selectors.get_enemies"

  it("returns all non-player characters", function()
    local p = { isPlayerControlled = true }
    local e1, e2, e3 = {}, {}, {}
    local state = {
      characters = {
        e3, p, e1, e2
      }
    }

    local result = get_enemies(state)
    assert.array_includes(e1, result)
    assert.array_includes(e2, result)
    assert.array_includes(e3, result)
    assert.not_array_includes(p, result)
  end)
end)