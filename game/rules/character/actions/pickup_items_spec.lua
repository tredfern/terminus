-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.pickup_items", function()
  local pickupItems = require "game.rules.character.actions.pickup_items"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local character = require "game.rules.character"
  local Position = require "game.rules.world.position"

  local pickup = { position = Position.new(17, 19), item = true }
  local getState = function()
    return {
      items = { pickup }
    }
  end

  before_each(function()
    mockStore {
      world = { pickup }
    }
  end)

  it("gets the items in the current character position", function()
    local c = { position = Position.new(17, 19) }

    local action = pickupItems(c)
    action(mockDispatch, getState)

    assert.is_true(mockDispatch:received_action(character.actions.types.ADD_ITEM_TO_INVENTORY))
    assert.equals(pickup, mockDispatch.dispatched[1].payload.item)
  end)

  it("removes the item that it picked up", function()
    local c = { position = Position.new(17, 19) }

    local action = pickupItems(c)
    assert.thunk_dispatches_type("ENTITY_REMOVE", action)
  end)
end)