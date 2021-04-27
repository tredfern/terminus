-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.reducer", function()
  local types = require "game.rules.message_log.actions.types"
  local reducer = require "game.rules.message_log.reducer"

  it("stores a formatted message from the add action", function()
    local state = {}
    state = reducer(state, {
      type = types.ADD,
      payload = { message = "Hello Message Log" }
    })

    -- First entry is a color
    assert.is_table(state[1].message[1])
    -- second entry is the text
    assert.equals("Hello Message Log", state[1].message[2])
  end)

  it("creates a new state if nil", function()
    local state = reducer(nil, {
      type = types.ADD,
      payload = { message = "Hello" }
    })

    assert.equals(1, #state)
  end)
end)