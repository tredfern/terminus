-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character.attributes", function()
  local character_attributes = require "game.ui.widgets.character.attributes"

  it("renders a component", function()
    assert.not_nil(character_attributes())
  end)
end)