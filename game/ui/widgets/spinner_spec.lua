-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.spinner", function()
  local Spinner = require "game.ui.widgets.spinner"

  it("creates a valid component", function()
    local spin = Spinner()
    assert.is_table(spin)
  end)

  it("raises events that can be hooked into on increasing/decreasing", function()
    local inc, dec = spy.new(function() end), spy.new(function() end)
    local s= Spinner { value = 3, onIncrease = inc, onDecrease = dec }
    s:increase()
    assert.spy(inc).was.called()
    s:decrease()
    assert.spy(dec).was.called()
  end)
end)