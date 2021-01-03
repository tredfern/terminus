-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.selectors.get_all_characters", function()
  local get_all_characters = require "game.rules.character.selectors.get_all_characters"

  it("returns all characters from state as an array", function()
    local c1,c2,c3 = {}, {}, {}
    local state = {
      characters = {
        c1, c2, c3
      }
    }

    assert.array_matches({ c1, c2, c3 }, get_all_characters(state))
  end)

  it("returns an empty array if characters is not assigned in state", function()
    assert.same({}, get_all_characters({}))
  end)
end)