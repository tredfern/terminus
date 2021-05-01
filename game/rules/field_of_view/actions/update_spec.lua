-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.actions.update", function()
  local update = require "game.rules.field_of_view.actions.update"

  it("takes an entity id, origin and visibility map for the field of view", function()
    local entity = {}
    local map = {}
    local action = update(entity, map)
    assert.equals("FIELD_OF_VIEW_UPDATE", action.type)
    assert.equals(entity, action.payload.entity)
    assert.equals(map, action.payload.visibilityMap)
  end)
end)