-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.actions.use", function()
  local use = require "game.rules.items.actions.use"
  local mockDispatch = require "test_helpers.mock_dispatch"

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
    local Character = require "game.rules.character"
    local item = { useHandler = function() end, consumeOnUse = true }
    local user = { inventory = { item } }

    local action = use(item, user)
    action(mockDispatch)

    assert.is_true(mockDispatch:received_action(Character.actions.types.remove_item_from_inventory))
    assert.equals(item, mockDispatch.dispatched[1].payload.item)
    assert.equals(user, mockDispatch.dispatched[1].payload.character)
  end)

  it("if item is marked as not consumable than do not remove item", function()
    local Character = require "game.rules.character"
    local item = { useHandler = function() end, consumeOnUse = false }
    local user = { inventory = { item } }

    local action = use(item, user)
    action(mockDispatch)
    assert.is_false(mockDispatch:received_action(Character.actions.types.remove_item_from_inventory))
  end)
end)