-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.character.attribute", function()
  local attribute = require "game.entities.character.attribute"

  it("defaults score and modifier to nil", function()
    local a = attribute()
    assert.is_nil(a.score)
    assert.is_nil(a:modifier())
  end)

  it("sets a zero score to a -3 modifier", function()
    local a = attribute(0)
    assert.equals(-3, a:modifier())
  end)

  it("set 1-2 to a -2 modifier", function()
    local a = attribute(1)
    assert.equals(-2, a:modifier())
    a = attribute(2)
    assert.equals(-2, a:modifier())
  end)

  it("sets a 3-5 to a -1 modifier", function()
    local a = attribute(3)
    assert.equals(-1, a:modifier())
    a = attribute(5)
    assert.equals(-1, a:modifier())
  end)

  it("sets a 6-8 to a 0 modifier", function()
    local a = attribute(6)
    assert.equals(0, a:modifier())
    a = attribute(8)
    assert.equals(0, a:modifier())
  end)

  it("sets a 9-11 to a +1 modifier", function()
    local a = attribute(9)
    assert.equals(1, a:modifier())
    a = attribute(11)
    assert.equals(1, a:modifier())
  end)

  it("set a 12-14 to a +2 modifier", function()
    local a = attribute(12)
    assert.equals(2, a:modifier())
    a = attribute(14)
    assert.equals(2, a:modifier())
  end)

  it("sets a 15 or higher to a +3 modifier", function()
    local a = attribute(15)
    assert.equals(3, a:modifier())
    a = attribute(24)
    assert.equals(3, a:modifier())
  end)
end)