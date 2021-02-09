-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.names", function()
  local names = require "game.rules.character.names"

  it("returns anonymous if no names exist", function()
    assert.equals("Anonymous", names.generate().first)
  end)

  it("can register names to use to generate", function()
    names.registerFirstNames("John")
    names.registerLastNames("Smith")

    local n = names.generate()
    assert.equals("John", n.first)
    assert.equals("Smith", n.last)
  end)

  it("can register multiple names at once", function()
    names.registerFirstNames("S", "A", "B", "C")
    names.registerLastNames("S", "A", "B", "C")

    assert.array_includes("S", names.firstNames)
    assert.array_includes("A", names.firstNames)
    assert.array_includes("B", names.firstNames)
    assert.array_includes("C", names.firstNames)
    assert.array_includes("S", names.lastNames)
    assert.array_includes("A", names.lastNames)
    assert.array_includes("B", names.lastNames)
    assert.array_includes("C", names.lastNames)
  end)

end)