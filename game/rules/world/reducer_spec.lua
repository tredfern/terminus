-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.reducer", function()
  local reducer = require "game.rules.world.reducer"
  local actionTypes = require "game.rules.world.actions.types"

  it("can add entities", function()
    local e1 = {}
    local action = {
      type = actionTypes.ENTITY_ADD,
      payload = {
        entity = e1
      }
    }

    local state = reducer({}, action)
    assert.equals(e1, state[1])
  end)

  it("can remove entities", function()
    local e1 = {}
    local action = {
      type = actionTypes.ENTITY_REMOVE,
      payload = {
        entity = e1
      }
    }

    local state = reducer({ e1 }, action)
    assert.not_array_includes(e1, state)
  end)
end)