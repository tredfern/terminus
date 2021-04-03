-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.actions.add_entity", function()
  local addEntity = require "game.rules.world.actions.add_entity"

  it("takes an entity to add to the database", function()
    local e1 = {}
    local action = addEntity(e1)
    assert.equals(e1, action.payload.entity)
    assert.equals("ENTITY_ADD", action.type)
  end)
end)