-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.add", function()
  local character_add = require "game.rules.character.actions.add"

  it("specifies the new character to add to the store", function()
    local c = {}
    local act = character_add(c)

    assert.equals("CHARACTER_ADD", act.type)
    assert.equals(c, act.payload.character)

  end)
end)