-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.set_position", function()
  local set_position = require "game.rules.character.actions.set_position"
  local types = require "game.rules.character.actions.types"

  it("specifies the position to update the character to", function()
    local c = {}
    local sp = set_position(c, 89, 38)
    assert.not_nil(sp.type)
    assert.equals(types.character_set_position, sp.type)
    assert.equals(c, sp.payload.character)
    assert.equals(89, sp.payload.x)
    assert.equals(38, sp.payload.y)
  end)

  it("is invalid if terrain blocks movement", function()
    local sp = set_position({}, 5, 3)
    local map = {
      get_terrain = function() return { blocks_movement = true } end
    }
    assert.is_false(sp:validate({ map = map }))
  end)

  it("is valid if terrain allows movement", function()
    local sp = set_position({}, 5, 3)
    local map = { get_terrain = function() return { } end }
    assert.is_true(sp:validate({ map = map }))
  end)

end)