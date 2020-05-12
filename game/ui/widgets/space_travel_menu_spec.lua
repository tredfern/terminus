-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.space_travel_menu", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local destinations = {
    spaceport:new { name = "Alpha" },
    spaceport:new { name = "Bravo" },
    spaceport:new { name = "Charlie" },
  }
  local travel_menu

  before_each(function()
    travel_menu = moonpie.ui.components.space_travel_menu { destinations = destinations }
  end)


  it("takes a list of destinations and creates buttons for them", function()
    assert.not_nil(travel_menu:find_by_id("goto_Alpha_button"))
    assert.not_nil(travel_menu:find_by_id("goto_Bravo_button"))
    assert.not_nil(travel_menu:find_by_id("goto_Charlie_button"))
  end)

  it("triggers travelling to another station when clicked", function()
    local btn = travel_menu:find_by_id("goto_Bravo_button")
    local rules = require "game.rules"
    spy.on(rules, "space_travel_to")
    btn:click()
    assert.spy(rules.space_travel_to).was.called_with(destinations[2])
  end)
end)