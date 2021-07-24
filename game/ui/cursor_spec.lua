-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.cursor", function()
  local Cursor = require "game.ui.cursor"
  local Position = require "game.rules.world.position"

  it("can show/hide the cursor", function()
    Cursor.show()
    assert.is_true(Cursor.isVisible)
    Cursor.hide()
    assert.is_false(Cursor.isVisible)
  end)

  it("can set the position of the cursor", function()
    Cursor.setPosition(Position(2, 3, 2))
    assert.equals(Position(2, 3, 2), Cursor.position)
  end)
end)