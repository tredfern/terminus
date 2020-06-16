-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.travel_to", function()
  local types = require "game.rules.actions.types"
  local travel_to = require "game.rules.actions.travel_to"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store{ location = { name = "Place A" } }
  end)

  it("updates the location to the new location", function()
    local new_location = { name = "someplace" }
    store.dispatch(travel_to(new_location))
    assert.not_nil(store.get_action_groups()[types.location_update])
    assert.equals(new_location, store.get_action_groups()[types.location_update][1].payload)
  end)

  it("provides some messages about moving", function()
    local new_location = { name = "someplace" }
    store.dispatch(travel_to(new_location))
    assert.greater_than(0, #store.get_action_groups()[types.message_add])
  end)
end)