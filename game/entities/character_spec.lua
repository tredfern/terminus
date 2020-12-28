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

  it("can be player controlled", function()
    local c = character { is_player_controlled = true }
    assert.is_true(c.is_player_controlled)
  end)

  it("can be identified as an enemy", function()
    local c = character { is_enemy = true }
    assert.is_true(c.is_enemy)
  end)

  it("can initialize it's position", function()
    local c = character { x = 142, y = 192 }
    assert.equals(142, c.x)
    assert.equals(192, c.y)
  end)
end)