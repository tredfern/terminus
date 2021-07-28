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

  it("can generate attribute stats based on a definition of the stat", function()
    assert.in_range(3, 4, attributes.generate("1d2+2"))
    assert.in_range(3, 5, attributes.generate("1d3+2"))
    assert.in_range(3, 8, attributes.generate("1d6+2"))
    assert.in_range(2, 12, attributes.generate("2d6"))
    assert.in_range(4, 24, attributes.generate("2d6+1d4+1d8"))
    assert.equals(10, attributes.generate(10))
  end)
end)