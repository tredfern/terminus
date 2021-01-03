-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.move", function()
  local character_move = require "game.rules.character.actions.move"

  it("is set to the position that the character should move to", function()
    local c = {}
    local act = character_move(c, 19, 10)

    assert.equals("CHARACTER_MOVE", act.type)
    assert.equals(c, act.payload.character)
    assert.equals(19, act.payload.x)
    assert.equals(10, act.payload.y)
  end)
end)