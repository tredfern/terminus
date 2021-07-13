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

  it("can increment the number", function()
    local rend = moonpie.testRender(Spinner { id = "spinner", value = 1 })
    rend:findByID("btnNextspinner"):click()
    local spin = rend:findByID("spinner")
    assert.equals(2, spin.value)
  end)

  it("can decrement the number", function()
    local rend = moonpie.testRender(Spinner { id = "spinner", value = 1 })
    rend:findByID("btnPrevspinner"):click()
    local spin = rend:findByID("spinner")
    assert.equals(0, spin.value)
  end)

  it("lets a subscriber know about the new value", function()
    local cb = spy.new(function() end)
    local s = Spinner { value = 10, onUpdate = cb }
    local rend = moonpie.testRender(s)
    rend:findByID("btnNext"):click()
    assert.spy(cb).was.called()
  end)

  it("can set the minimum and maximum and that forces the spinner to stay in range", function()
    local s = Spinner { value = 4, minimum = 3, maximum = 6 }
    s:decrease()
    s:decrease()
    s:decrease()
    assert.equals(3, s.value)
    s:increase()
    s:increase()
    s:increase()
    s:increase()
    s:increase()
    assert.equals(6, s.value)
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