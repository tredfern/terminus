-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.selectors", function()
  local selectors = require "game.rules.inventory.selectors"


  describe("SELECTOR: getInventory", function()
    local entity, entityInventory = {}, {}
    local state = {
      inventory = {
        [entity] = entityInventory
      }
    }

    assert.equals(entityInventory, selectors.getInventory(state, entity))
  end)

  describe("SELECTOR: isCarryingItem", function()
    local entity, item = {}, {}
    local entityInventory = {
      carried = {
        { item = item, quantity = 3 }
      }
    }
    local state = {
      inventory = {
        [entity] = entityInventory
      }
    }

    assert.is_true(selectors.isCarryingItem(state, entity, item))
    assert.is_false(selectors.isCarryingItem(state, entity, {}))
  end)
end)