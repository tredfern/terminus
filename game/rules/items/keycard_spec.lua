-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.keycard", function()
  local Keycard = require "game.rules.items.keycard"
  local Position = require "game.rules.world.position"

  it("has actions to add keycards to the map", function()
    local action = Keycard.actions.add(Position(1, 4, 2))
    assert.equals("ENTITY_ADD", action.type)
    assert.equals("Keycard", action.payload.entity.name)
    assert.equals("keycard", action.payload.entity.key)
    assert.equals(Position(1, 4, 2), action.payload.entity.position)
    assert.not_nil(action.payload.entity.sprite)
    assert.is_true(action.payload.entity.item)
  end)
end)