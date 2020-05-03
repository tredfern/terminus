-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screen.main_layout", function()
  require "game.ui"

  it("configures a renderable component", function()
    assert.not_nil(moonpie.ui.components.main_layout)
    moonpie.ui.components.main_layout()
  end)



end)