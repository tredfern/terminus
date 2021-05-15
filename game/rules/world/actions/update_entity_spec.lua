-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.actions.update_entity", function()
  local updateEntity = require "game.rules.world.actions.update_entity"

  it("takes an entity ID and some properties to update", function()
    local entity = {}
    local values = {
      a = 1, b = 2, c = 3
    }
    local action = updateEntity(
      entity,
      values
    )

    assert.equals("WORLD_ENTITY_UPDATE", action.type)
    assert.equals(entity, action.payload.entity)
    assert.equals(values, action.payload.values)
  end)
end)