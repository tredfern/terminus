-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.equip", function()
  local Equip = require "game.ui.create_character.equip"

  it("renders a component", function()
    assert.is_table(Equip())
  end)
end)