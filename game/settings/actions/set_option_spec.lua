-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.settings.actions.set_option", function()
  local setOption = require "game.settings.actions.set_option"

  it("can specify an option and a value for that setting to have", function()
    local action = setOption("show_grid_lines", false)
    assert.equals("SETTINGS_SET_OPTION", action.type)
    assert.equals("show_grid_lines", action.payload.name)
    assert.equals(false, action.payload.value)
  end)
end)