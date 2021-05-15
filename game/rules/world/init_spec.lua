-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world", function()
  local World = require "game.rules.world"

  it("has actions to updated entities", function()
    assert.not_nil(World.actions.addEntity)
    assert.not_nil(World.actions.removeEntity)
    assert.not_nil(World.actions.updateEntity)
  end)

  it("has selectors to find entities", function()
    assert.not_nil(World.selectors.getAllWithComponents)
    assert.not_nil(World.selectors.getByPosition)
  end)

  it("provides access to it's useful pieces", function()
    local Position = require "game.rules.world.position"
    assert.equals(Position, World.position)
    local Orientation = require "game.rules.world.orientation"
    assert.equals(Orientation, World.orientation)
  end)
end)