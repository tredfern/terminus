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
    local s = Spinner { value = 10, eventUpdated = cb }
    local rend = moonpie.testRender(s)
    rend:findByID("btnNext"):click()
    assert.spy(cb).was.called()
  end)
end)