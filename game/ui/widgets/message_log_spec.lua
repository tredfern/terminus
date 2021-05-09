-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.message_log", function()
  local message_log = require "game.ui.widgets.message_log"
  local mockStore = require "moonpie.test_helpers.mock_store"

  before_each(function()
    mockStore {
      message_log = {
        { message = "1" },
        { message = "2" },
        { message = "3" },
        { message = "4" },
        { message = "5" },
        { message = "6" },
        { message = "7" },
      }
    }
  end)

  it("creates a component that gets the message_log from state", function()
    local ml = message_log()
    assert.is_true(#ml.messages > 0)
  end)
end)