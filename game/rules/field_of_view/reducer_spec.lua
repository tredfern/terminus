-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.field_of_view.reducer", function()
  local reducer = require "game.rules.field_of_view.reducer"
  local actionTypes = require "game.rules.field_of_view.types"

  it("can store the field of view for an entity", function()
    local state, entity, visibilityMap = {}, {}, {}

    local action = {
      type = actionTypes.UPDATE,
      payload = {
        entity = entity,
        visibilityMap = visibilityMap
      }
    }
    state = reducer(state, action)

    assert.not_nil(state[entity])
    assert.equals(visibilityMap, state[entity])
  end)
end)