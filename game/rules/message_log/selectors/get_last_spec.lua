-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.message_log.selectors.get_last", function()
  local get_last = require "game.rules.message_log.selectors.get_last"

  it("gets the last x number of entries from state", function()
    local state = {
      message_log = {
        { message = "1" },
        { message = "2" },
        { message = "3" },
        { message = "4" },
        { message = "5" },
        { message = "6" },
        { message = "7" },
        { message = "8" },
        { message = "9" },
        { message = "10" },
      }
    }

    local results = get_last(state, 5)
    assert.equals(5, #results)
    assert.equals("10", results[1].message)
    assert.equals("9", results[2].message)
    assert.equals("8", results[3].message)
    assert.equals("7", results[4].message)
    assert.equals("6", results[5].message)
  end)

  it("returns an empty array if no message_log state", function()
    local results = get_last({}, 19)
    assert.equals(0, #results)
  end)
end)