-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.set_attribute", function()
  local attributes = require "game.rules.character.attributes"
  local setAttribute = require "game.rules.character.actions.set_attribute"

  it("takes an attribute name and a value", function()
    local character = {}
    local action = setAttribute(character, attributes.strength, 15)
    assert.equals("CHARACTER_SET_ATTRIBUTE", action.type)
    assert.equals(character, action.payload.character)
    assert.equals(attributes.strength, action.payload.attribute)
    assert.equals(15, action.payload.value)
  end)
end)