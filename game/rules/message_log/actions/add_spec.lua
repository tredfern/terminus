-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.actions.add", function()
  local add = require "game.rules.message_log.actions.add"

  it("takes a message to store in the message log", function()
    local action = add("Hello!")
    assert.equals("MESSAGE_LOG_ADD", action.type)
    assert.equals("Hello!", action.payload.message)
  end)

  it("accepts additional data for formatting", function()
    local action = add("Hello {{charactername}}!", {
      charactername = "Foo"
    })

    assert.equals("Foo", action.payload.formatData.charactername)
  end)
end)