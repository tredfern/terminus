-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.set_name", function()
  local set_name = require "game.rules.character.actions.set_name"

  it("sets up an action that specifies the character name to change", function()
    local c = {}
    local action = set_name(c, "Bar")

    assert.equals("CHARACTER_SET_NAME", action.type)
    assert.equals(c, action.payload.character)
    assert.equals("Bar", action.payload.name)
  end)
end)