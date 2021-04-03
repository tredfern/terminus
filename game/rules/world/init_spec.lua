-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world", function()
  local World = require "game.rules.world"

  it("has actions to updated entities", function()
    assert.not_nil(World.actions.addEntity)
    assert.not_nil(World.actions.removeEntity)
  end)

  it("has selectors to find entities", function()
    assert.not_nil(World.selectors.getAllWithComponents)
  end)
end)