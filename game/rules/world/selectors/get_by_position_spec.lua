-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.selectors.get_by_position", function()
  local getByPosition = require "game.rules.world.selectors.get_by_position"
  local Position = require "game.rules.world.position"

  it("returns all entities that are at a specific position", function()
    local e1 = { position = Position(1, 4, 2) }
    local e2 = { position = Position(1, 4, 2) }
    local e3 = { position = Position(1, 4, 1) }
    local e4 = { position = Position(1, 4, 2) }

    local state = {
      characters = { e1 },
      items = { e2, e3 },
      world = {
        e4
      }
    }

    local result = getByPosition(state, Position(1, 4, 2))
    assert.equals(3, #result)
    assert.array_includes(e1, result)
    assert.array_includes(e2, result)
    assert.array_includes(e4, result)
    assert.not_array_includes(e3, result)
  end)

  it("returns only entities that contain matching additional components", function()
    local e1 = { position = Position(1, 4, 2), comp = true }
    local e2 = { position = Position(1, 4, 2) }
    local e3 = { position = Position(1, 4, 1) }
    local e4 = { position = Position(1, 4, 2), comp = true, foo = "bar" }

    local state = {
      characters = { e1 },
      items = { e2, e3 },
      world = {
        e4
      }
    }
    local result = getByPosition(state, Position(1, 4, 2), "comp", "foo")

    assert.not_array_includes(e1, result)
    assert.not_array_includes(e2, result)
    assert.not_array_includes(e3, result)
    assert.array_includes(e4, result)
  end)
end)