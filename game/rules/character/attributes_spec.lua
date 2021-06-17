-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.attributes", function()
  local attributes = require "game.rules.character.attributes"

  it("has types of attributes available", function()
    assert.equals("STRENGTH", attributes.strength)
    assert.equals("DEXTERITY", attributes.dexterity)
    assert.equals("ENDURANCE", attributes.endurance)
    assert.equals("INTELLIGENCE", attributes.intelligence)
    assert.equals("KNOWLEDGE", attributes.knowledge)
    assert.equals("CHARISMA", attributes.charisma)
  end)

  it("rolls 2d6 for the attribute score", function()
    assert.in_range(2, 12, attributes.roll())
  end)

  it("returns a list of attributes for the point buy", function()
    assert.same({ 4, 5, 6, 7, 8, 9 }, attributes.pointBuyStart())
  end)
end)