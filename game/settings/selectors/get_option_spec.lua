-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.settings.selectors.get_option", function()
  local getOption = require "game.settings.selectors.get_option"

  it("retrieves a setting out of the state", function()
    local s = {
      settings = {
        setting_a = "foo",
        setting_b = "bar"
      }
    }

    assert.equals("foo", getOption(s, "setting_a"))
    assert.equals("bar", getOption(s, "setting_b"))
  end)
end)