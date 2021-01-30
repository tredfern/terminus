-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log", function()
  local message_log = require "game.rules.message_log"

  it("has an action to add an event to the message log", function()
    assert.not_nil(message_log.actions.add)
  end)

  it("has a selector to get the most recent actions", function()
    assert.not_nil(message_log.selectors.get_last)
  end)
end)