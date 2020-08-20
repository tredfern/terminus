-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.character.name_update", function()
  local action_types = require "game.rules.actions.types"
  local name_update = require "game.rules.actions.character.name_update"

  it("takes a payload for the name", function()
    local n = name_update("Harold Frazier")
    assert.equals("Harold Frazier", n.payload)
  end)

  it("has the character.name_update action_type", function()
    local n = name_update("Harold Frazier")
    assert.equals(action_types.character.name_update, n.type)
  end)
end)