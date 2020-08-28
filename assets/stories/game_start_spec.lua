-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("assets.stories.game_start", function()
  local action_types = require "game.rules.actions.types"
  local game_start = require "assets.stories.game_start"
  local mock_store = require "mock_store"
  local store = require "moonpie.redux.store"

  it("has one action that initiates the combat event", function()
    mock_store({})
    game_start.choices[1].event()
    assert.greater_than(0, #store.get_actions(action_types.game_state_change))
    assert.equals("combat", store.get_actions(action_types.game_state_change)[1].payload)

  end)
end)