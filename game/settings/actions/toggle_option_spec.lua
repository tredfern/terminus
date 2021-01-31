-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.settings.actions.toggle_option", function()
  local toggleOption = require "game.settings.actions.toggle_option"

  it("it takes a setting to toggle", function()
    local action = toggleOption("show_grid_lines")
    assert.equals("SETTINGS_TOGGLE_OPTION", action.type)
    assert.equals("show_grid_lines", action.payload.name)
  end)
end)