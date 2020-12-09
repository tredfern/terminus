-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.entities.character", function()
  local character = require "game.entities.character"

  it("instantiates a character class", function()
    local c = character()
    assert.equals(0, c.x)
    assert.equals(0, c.y)
  end)

  it("can set the position", function()
    local c = character()
    c:set_position(20, 28)
    assert.equals(20, c.x)
    assert.equals(28, c.y)
  end)
end)