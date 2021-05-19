-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.world.selectors", function()
  local selectors = require "game.rules.world.selectors"
  local Position = require "game.rules.world.position"

  describe("SELECTOR: getAllWithComponents", function()
    it("returns any entity from characters, items, or world that has these components", function()
      local e1 = { x = 1, y = 1, image = {} }
      local e2 = { x = 1, y = 1, image = {} }
      local e3 = { x = 1, y = 1 }
      local e4 = { x = 1, y = 1, image = {} }

      local state = {
        characters = { e1 },
        items = { e2, e3 },
        world = {
          e4
        }
      }

      local out = selectors.getAllWithComponents(state, "x", "y", "image")
      assert.array_includes(e1, out)
      assert.array_includes(e2, out)
      assert.array_includes(e4, out)
      assert.not_array_includes(e3, out)
    end)
  end)

  describe("game.rules.world.selectors.get_by_position", function()
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

      local result = selectors.getByPosition(state, Position(1, 4, 2))
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
      local result = selectors.getByPosition(state, Position(1, 4, 2), "comp", "foo")

      assert.not_array_includes(e1, result)
      assert.not_array_includes(e2, result)
      assert.not_array_includes(e3, result)
      assert.array_includes(e4, result)
    end)
  end)
end)