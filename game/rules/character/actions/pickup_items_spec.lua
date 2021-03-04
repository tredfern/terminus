-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.pickup_items", function()
  local pickupItems = require "game.rules.character.actions.pickup_items"
  local mockDispatch = require "test_helpers.mock_dispatch"
  local character = require "game.rules.character"

  local pickup = { x = 17, y = 19}
  local getState = function()
    return {
      items = { pickup }
    }
  end

  it("gets the items in the current character position", function()
    local c = { x = 17, y = 19 }

    local action = pickupItems(c)
    action(mockDispatch, getState)

    assert.is_true(mockDispatch:received_action(character.actions.types.character_add_item_to_inventory))
    assert.equals(pickup, mockDispatch.dispatched[1].payload.item)
  end)

  it("removes the item that it picked up", function()
    local itemActionTypes = require "game.rules.items.actions.types"
    local c = { x = 17, y = 19 }

    local action = pickupItems(c)
    action(mockDispatch, getState)

    assert.is_true(mockDispatch:received_action(itemActionTypes.remove))
  end)
end)