-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.actions.remove_entity", function()
  local removeEntity = require "game.rules.world.actions.remove_entity"

  it("identifies the entity to remove", function()
    local e1 = {}
    local action = removeEntity(e1)
    assert.equals("ENTITY_REMOVE", action.type)
    assert.equals(e1, action.payload.entity)
  end)
end)