-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screen.ship_combat", function()
  require "game.ui"

  it("configures a renderable component", function()
    assert.not_nil(moonpie.ui.components.screens_ship_combat)
    moonpie.ui.components.screens_ship_combat()
  end)



end)