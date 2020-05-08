-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screen.main_layout", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local starship = require "game.entities.starship"

  it("configures a renderable component", function()
    assert.not_nil(moonpie.ui.components.main_layout)
    moonpie.ui.components.main_layout{
      spaceport = spaceport:new{ name = "Earth" },
      player = starship:new()
    }
  end)



end)