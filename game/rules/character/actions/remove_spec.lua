-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.remove", function()
  local remove = require "game.rules.character.actions.remove"
  local types = require "game.rules.character.actions.types"

  it("describes the character that needs to be removed", function()
    local c = {}
    local action = remove(c)

    assert.not_nil(action.type)
    assert.equals(types.character_remove, action.type)
    assert.equals(c, action.payload.character)
  end)
end)