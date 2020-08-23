-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.statemachine", function()
  local action_types = require "game.rules.actions.types"
  local statemachine = require "game.statemachine"
  local mock_store = require "mock_store"
  local store

  before_each(function()
    store = mock_store({
      game_state = {
        current = "start"
      }
    })
  end)

  it("it starts up and dispatches to the store that the current state is 'start'", function()
    statemachine:start()
    assert.equals("start", store.get_actions(action_types.game_state_change)[1].payload)
  end)

  it("can return the state of the current state", function()
    assert.equals("start", statemachine.current())
  end)
end)