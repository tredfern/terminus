-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.reducers.message_log", function()
  local message_log_reducer = require "game.rules.reducers.message_log"
  local add_message = require "game.rules.actions.message_add"

  it("can add new messages", function()
    local state = message_log_reducer({}, add_message("A message"))
    assert.equals("A message", state[1].message)
  end)

  it("appends multiple messages together", function()
    local state = message_log_reducer({}, add_message("A message"))
    state = message_log_reducer(state, add_message("B message"))
    state = message_log_reducer(state, add_message("C message"))

    assert.equals("A message", state[1].message)
    assert.equals("B message", state[2].message)
    assert.equals("C message", state[3].message)
  end)

  it("returns it's current state if not it's action", function()
    local state = message_log_reducer({}, { type = "something random" })
    assert.not_nil(state)
  end)
end)