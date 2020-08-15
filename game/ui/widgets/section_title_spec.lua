-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.section_title", function()
  local section_title = require "game.ui.widgets.section_title"

  it("instantiates a component", function()
    assert.not_nil(section_title())
  end)
end)