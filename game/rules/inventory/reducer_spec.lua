-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.reducer", function()
  local reducer = require "game.rules.inventory.reducer"
  local actions = require "game.rules.inventory.actions"
  local equipSlots = require "game.rules.inventory.equip_slots"

  describe("ACTION: addItem", function()
    it("adds an item to the inventory for the entity", function()
      local entity, item = {}, {}
      local action = actions.addItem(entity, item)
      local state = reducer({}, action)
      assert.not_nil(state[entity])
      assert.not_nil(state[entity].carried)
      assert.equals(item, state[entity].carried[1].item)
      assert.equals(1, state[entity].carried[1].quantity)
    end)

    it("increments the quantity if the item already is added", function()
      local entity, item = {}, {}
      local action = actions.addItem(entity, item)
      local state = {}
      state = reducer(state, action)
      state = reducer(state, action)
      state = reducer(state, action)
      state = reducer(state, action)
      assert.equals(4, state[entity].carried[1].quantity)
    end)
  end)

  describe("ACTION: removeItem", function()
    it("reduces the quantity of items from the inventory", function()
      local entity, item = {}, {}
      local action = actions.removeItem(entity, item)
      local state = {
        [entity] = {
          carried = {
            { item = item, quantity = 4 }
          }
        }
      }

      state = reducer(state, action)
      assert.equals(3, state[entity].carried[1].quantity)
    end)

    it("removes the item slot if the quantity is zero", function()
      local entity, item = {}, {}
      local action = actions.removeItem(entity, item)
      local state = {
        [entity] = {
          carried = {
            { item = item, quantity = 1 }
          }
        }
      }

      state = reducer(state, action)
      assert.is_nil(state[entity].carried[1])
    end)
  end)

  describe("ACTION: equipItem", function()
    it("sets the item into the slot specified by the item", function()
      local entity = {}
      local item = { equipSlot = equipSlots.melee }

      local action = actions.equipItem(entity, item)
      local state = reducer({}, action)

      assert.equals(item, state[entity].equipped[equipSlots.melee])
    end)
  end)
end)