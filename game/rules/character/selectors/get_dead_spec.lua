-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_dead", function()
  local get_dead = require 'game.rules.character.selectors.get_dead'

  it("return all characters that have a health of 0", function()
    local alive = { health = 1 }
    local dead1 = { health = 0 }
    local dead2 = { health = -4 }
    local state = {
      characters = {
        alive, dead1, dead2
      }
    }

    local results = get_dead(state)
    assert.equals(2, #results)
    assert.array_includes(dead1, results)
    assert.array_includes(dead2, results)
  end)
end)