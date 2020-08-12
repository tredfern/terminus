-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.views.show_market", function()
  local types = require "game.rules.actions.types"
  local show_market = require "game.rules.actions.views.show_market"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store({})
    store.dispatch(show_market())
  end)

  it("uses the market widget as the payload for the action", function()
    assert.equals(1, #store.get_action_groups()[types.game_view_set])
  end)

  it("sets the available actions for the view", function()
    assert.greater_than(0, #store.get_action_groups()[types.game_view_action_add])
  end)
end)