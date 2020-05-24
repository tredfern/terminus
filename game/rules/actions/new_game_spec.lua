-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.new_game", function()
  local action_types = require "game.rules.actions.types"
  local new_game = require "game.rules.actions.new_game"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store({ spaceports = { { name = "Alpha" }, { name = "Bravo" } } })
  end)

  it("dispatches add_spaceport actions", function()
    store.dispatch(new_game())

    local state = store.get_state()
    local groups = moonpie.utility.tables.group_by(state.actions, function(a) return a.type end)
    assert.greater_than(1, #groups[action_types.spaceport_add])
  end)

  it("sets up an initial location", function()
    store.dispatch(new_game())
    local state = store.get_state()
    local groups = moonpie.utility.tables.group_by(state.actions, function(a) return a.type end)
    assert.equals(1, #groups[action_types.location_update])
  end)
end)