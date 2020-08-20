-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.character", function()
  local character = require "game.entities.character"

  it("can create a named character", function()
    local c = character { name = "Foo" }
    assert.equals("Foo", c.name)
  end)

  it("has basic attributes all set to nil", function()
    local c = character()
    assert.is_nil(c.strength.score)
    assert.is_nil(c.dexterity.score)
    assert.is_nil(c.endurance.score)
    assert.is_nil(c.intelligence.score)
    assert.is_nil(c.knowledge.score)
    assert.is_nil(c.personality.score)
  end)
end)