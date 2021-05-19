-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.reducer", function()
  local reducer = require "game.rules.turn.reducer"
  local Actions = require "game.rules.turn.actions"

  it("increments the turn counter when receiving the increment action", function()
    local state = {
      counter = 2
    }

    local new_state = reducer(state, Actions.increment())
    assert.equals(3, new_state.counter)
  end)

  it("sets counter to 1 if counter is nil", function()
    local state = {}

    local new_state = reducer(state, Actions.increment())
    assert.equals(1, new_state.counter)
  end)

  it("sets the initial state of the turn store to 0", function()
    local state = reducer(nil, {})
    assert.equals(0, state.counter)
  end)
end)