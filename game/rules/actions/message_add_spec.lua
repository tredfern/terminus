-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.add_message", function()
  local add_message = require "game.rules.actions.message_add"
  local types = require "game.rules.actions.types"

  it("contains some text to represent the message", function()
    local msg = add_message("Hi! I'm a message")
    assert.equals("Hi! I'm a message", msg.payload.message)
  end)

  it("contains the type of message", function()
    local msg = add_message("A Message")
    assert.not_nil(msg.type)
    assert.equals(types.message_add, msg.type)
  end)
end)