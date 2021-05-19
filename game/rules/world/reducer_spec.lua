-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.reducer", function()
  local reducer = require "game.rules.world.reducer"
  local Actions = require "game.rules.world.actions"

  it("can add entities", function()
    local e1 = {}
    local action = {
      type = Actions.types.ENTITY_ADD,
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
      type = Actions.types.ENTITY_REMOVE,
      payload = {
        entity = e1
      }
    }

    local state = reducer({ e1 }, action)
    assert.not_array_includes(e1, state)
  end)

  it("can update entities", function()
    local e1 = { b = 5 }
    local action = {
      type = Actions.types.ENTITY_UPDATE,
      payload = {
        entity = e1,
        values = {
          a = 1, b = 2, c = 3
        }
      }
    }

    local state = reducer({ e1 }, action)
    assert.array_includes(e1, state)
    assert.equals(1, e1.a)
    assert.equals(2, e1.b)
    assert.equals(3, e1.c)
  end)
end)