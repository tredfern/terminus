-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.items.actions.use", function()
  local use = require "game.rules.items.actions.use"
  local mockDispatch = require "mock_dispatch"

  before_each(function()
    mockDispatch:reset()
  end)

  it("calls the item use handler", function()
    local item = {
      useHandler = spy.new(function() end)
    }

    local action = use(item)
    action(mockDispatch)

    assert.spy(item.useHandler).was.called_with(item, nil)
  end)

  it("passes the user of the item to the handler", function()
    local item = { useHandler = spy.new(function() end)}
    local user = {}

    local action = use(item, user)
    action(mockDispatch)

    assert.spy(item.useHandler).was.called_with(item, user)
  end)

  it("removes the item from the characters inventory if it is a consumable", function()
    local Character = require "game.rules.character"
    local item = { useHandler = function() end, consumable = true }
    local user = { inventory = { item } }

    local action = use(item, user)
    action(mockDispatch)

    assert.is_true(mockDispatch:received_action(Character.actions.types.remove_item_from_inventory))
    assert.equals(item, mockDispatch.dispatched[1].payload.item)
    assert.equals(user, mockDispatch.dispatched[1].payload.character)
  end)
end)