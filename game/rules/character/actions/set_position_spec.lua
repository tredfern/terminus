-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.set_position", function()
  local Position = require "game.rules.world.position"
  local set_position = require "game.rules.character.actions.set_position"
  local types = require "game.rules.character.actions.types"

  it("specifies the position to update the character to", function()
    local c = {}
    local sp = set_position(c, Position(89, 38))
    assert.not_nil(sp.type)
    assert.equals(types.SET_POSITION, sp.type)
    assert.equals(c, sp.payload.character)
    assert.equals(89, sp.payload.position.x)
    assert.equals(38, sp.payload.position.y)
  end)

  it("is invalid if terrain blocks movement", function()
    local sp = set_position({}, Position(5, 3))
    local map = {
      getTerrain = function() return { blocksMovement = true } end
    }
    assert.is_false(sp:validate({ map = map }))
  end)

  it("is valid if terrain allows movement", function()
    local sp = set_position({}, Position(5, 3))
    local map = {
      tileMap = {
        getTile = function() return { terrain = {} } end
      }
    }
    assert.is_true(sp:validate({ map = map }))
  end)

end)