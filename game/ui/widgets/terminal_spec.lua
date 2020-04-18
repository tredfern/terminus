-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.terminal", function()
  require "game.ui"

  it("requires to be set to a certain number of character dimensions", function()
    assert.has_errors(function() moonpie.ui.components.terminal{ } end)
  end)

  it("can find an element", function()
    local term = moonpie.ui.components.terminal{ rows = 10, cols = 20 }
    assert.not_nil(term:get(3, 4))
  end)


  it("can set the text for a specific position", function()
    local term = moonpie.ui.components.terminal{
      cols = 10, rows = 5
    }
    term:set(2, 4, "a")
    assert.equals("a", term:get(2, 4).text)
  end)

  it("sets the width and height of the cells based on the area available", function()
    local term = moonpie.ui.components.terminal{ cols = 20, rows = 20 }
    local cell = term:get(3, 5)
    assert.equals("5.000000%", cell.width)

    local row = term:get_row(4)
    assert.equals("5.000000%", row.height)
  end)
end)