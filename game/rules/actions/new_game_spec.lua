-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.new_game", function()
  local action_types = require "game.rules.actions.types"
  local new_game = require "game.rules.actions.new_game"
  local mock_store = require "mock_store"
  local store, action_groups

  before_each(function()
    store = mock_store({ spaceports = { { name = "Alpha" }, { name = "Bravo" } } })
    store.dispatch(new_game())
    local state = store.get_state()
    action_groups = moonpie.utility.tables.group_by(state.actions, function(a) return a.type end)
  end)

  it("dispatches add_spaceport actions", function()
    assert.greater_than(1, #action_groups[action_types.spaceport_add])
  end)

  it("sets up an initial location", function()
    assert.equals(1, #action_groups[action_types.location_update])
  end)

  it("sets initial cargo for player", function()
    assert.greater_than(1, #action_groups[action_types.cargo_update])
  end)

  it("sets some initial prices for goods", function()
    assert.greater_than(1, #action_groups[action_types.market_add_item])
  end)

  it("sets the starting funds", function()
    assert.equals(1, #action_groups[action_types.money_update])
  end)

end)