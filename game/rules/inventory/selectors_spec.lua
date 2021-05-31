-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.selectors", function()
  local selectors = require "game.rules.inventory.selectors"
  local equipSlots = require "game.rules.inventory.equip_slots"


  describe("SELECTOR: getEquippedItem", function()
    local entity, item = {}, {}
    local entityInventory = {
      equipped = {
        [equipSlots.MELEE] = item
      }
    }
    local state = {
      inventory = {
        [entity] = entityInventory
      }
    }


    it("returns the equipped item", function()
      assert.equals(item, selectors.getEquippedItem(state, entity, equipSlots.MELEE))
    end)

    it("returns nil if no inventory for entity", function()
      assert.is_nil(selectors.getEquippedItem(state, {}, equipSlots.MELEE))
    end)
  end)

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