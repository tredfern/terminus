-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.add", function()
  local addCharacter = require "game.rules.character.actions.add"

  it("specifies the new character to add to the store", function()
    local c = {}
    local act = addCharacter(c)

    assert.equals("CHARACTER_ADD", act.type)
    assert.equals(c, act.payload.character)

  end)
end)