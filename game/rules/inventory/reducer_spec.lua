-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.inventory.reducer", function()
  local reducer = require "game.rules.inventory.reducer"
  local actions = require "game.rules.inventory.actions"

  describe("ACTION: addItem", function()
    it("adds an item to the inventory for the entity", function()
      local entity, item = {}, {}
      local action = actions.addItem(entity, item)
      local state = reducer({}, action)
      assert.not_nil(state[entity])
      assert.not_nil(state[entity].inventory)
      assert.equals(item, state[entity].inventory[1].item)
      assert.equals(1, state[entity].inventory[1].quantity)
    end)

    it("increments the quantity if the item already is added", function()
      local entity, item = {}, {}
      local action = actions.addItem(entity, item)
      local state = {}
      state = reducer(state, action)
      state = reducer(state, action)
      state = reducer(state, action)
      state = reducer(state, action)
      assert.equals(4, state[entity].inventory[1].quantity)
    end)
  end)
end)