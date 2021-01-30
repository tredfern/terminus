-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.reducer", function()
  local types = require "game.rules.message_log.actions.types"
  local reducer = require "game.rules.message_log.reducer"

  it("stores messages from the add action", function()
    local state = {}
    state = reducer(state, {
      type = types.message_log_add,
      payload = { message = "Hello Message Log" }
    })

    assert.equals("Hello Message Log", state[1].message)
  end)

  it("creates a new state if nil", function()
    local state = reducer(nil, {
      type = types.message_log_add,
      payload = { message = "Hello" }
    })

    assert.equals("Hello", state[1].message)
  end)
end)