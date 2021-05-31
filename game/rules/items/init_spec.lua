-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items", function()
  local Items = require "game.rules.items"
  local Position = require "game.rules.world.position"

  it("ACTION: add", function()
    local item = { }
    local position = {}
    local action = Items.actions.add(item, position)
    assert.equals("ENTITY_ADD", action.type)
    assert.equals(item, action.payload.entity)
    assert.equals(position, action.payload.entity.position)
  end)

  it("ACTION: remove", function()
    local item = {}
    local action = Items.actions.remove(item)

    assert.equals(item, action.payload.entity)
    assert.equals("ENTITY_REMOVE", action.type)
  end)

  describe("game.rules.items.actions.use", function()
    local use = Items.actions.use
    local mockDispatch = require "moonpie.test_helpers.mock_dispatch"

    before_each(function()
      mockDispatch:reset()
    end)

    it("calls the item use handler with dispatch", function()
      local item = {
        useHandler = spy.new(function() end)
      }

      local action = use(item)
      action(mockDispatch.asFunction)

      assert.spy(item.useHandler).was.called_with(item, mockDispatch.asFunction, nil)
    end)

    it("passes the user of the item to the handler", function()
      local item = { useHandler = spy.new(function() end)}
      local user = {}

      local action = use(item, user)
      action(mockDispatch.asFunction)

      assert.spy(item.useHandler).was.called_with(item, mockDispatch.asFunction, user)
    end)

    it("removes the item from the characters inventory", function()
      local Inventory = require "game.rules.inventory"
      local item = { useHandler = function() end, consumeOnUse = true }
      local user = { inventory = { item } }

      local action = use(item, user)
      assert.thunk_dispatches(Inventory.actions.removeItem(user, item), action)
    end)

    it("if item is marked as not consumable than do not remove item", function()
      local Inventory = require "game.rules.inventory"
      local item = { useHandler = function() end, consumeOnUse = false }
      local user = { inventory = { item } }

      local action = use(item, user)
      assert.not_thunk_dispatches_type(Inventory.actions.types.REMOVE_ITEM, action)
    end)
  end)

  it("has actions to manage items", function()
    assert.not_nil(Items.actions.add)
    assert.not_nil(Items.actions.remove)
    assert.not_nil(Items.actions.use)
  end)

  it("has selectors to retrieve items", function()
    assert.not_nil(Items.selectors.getAll)
    assert.not_nil(Items.selectors.getByPosition)
  end)

  it("can identify usable items", function()
    local usable = { useHandler = function() end }
    local unusable = { }

    assert.is_true(Items.isUsable(usable))
    assert.is_false(Items.isUsable(unusable))
  end)

  it("SELECTOR: getAll", function()
    local i1 = { item = true }
    local i2 = { item = true }
    local i3 = { item = true }
    local state = { items = { i1, i2 }, world = { i3 } }

    assert.array_includes(i1, Items.selectors.getAll(state))
    assert.array_includes(i2, Items.selectors.getAll(state))
    assert.array_includes(i3, Items.selectors.getAll(state))
  end)

  it("SELECTOR: getByPosition", function()
    local find1 = { position = Position.new(12, 17), item = true }
    local find2 = { position = Position.new(12, 17), item = true }
    local skip = { position = Position.new(2, 7), item = true }

    local state = {
      items = { find1, find2, skip }
    }
    local found = Items.selectors.getByPosition(state, Position(12, 17))

    assert.array_includes(find1, found)
    assert.array_includes(find2, found)
    assert.not_array_includes(skip, found)
  end)
end)