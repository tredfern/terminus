-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.settings.reducer", function()
  local reducer = require "game.settings.reducer"

  it("can change or set an option", function()
    local s = reducer({}, {
      type = "SETTINGS_SET_OPTION",
      payload = {
        name = "show_grid_lines",
        value = true
      }
    })
    assert.is_true(s.show_grid_lines)
  end)

  it("can toggle an option to an opposite boolean state", function()
    local action = {
      type = "SETTINGS_TOGGLE_OPTION",
      payload = { name = "show_grid_lines" }
    }
    local s = reducer({}, action)
    assert.is_true(s.show_grid_lines)
    s = reducer(s, action)
    assert.is_false(s.show_grid_lines)
    s = reducer(s, action)
    assert.is_true(s.show_grid_lines)
  end)
end)