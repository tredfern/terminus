-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.row", function()
  local Row = require "game.ui.widgets.row"

  it("sets the width of any child that has columnWidth property based on the number of columns", function()
    local r = Row({
      columns = 5,
      { columnWidth = 1 },
      { columnWidth = 2 },
      { columnWidth = 2 }
    })

    assert.equals("20%", r[1].width)
    assert.equals("40%", r[2].width)
    assert.equals("40%", r[3].width)
  end)
end)