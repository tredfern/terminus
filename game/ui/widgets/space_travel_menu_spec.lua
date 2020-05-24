-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.space_travel_menu", function()
  require "game.ui"
  local spaceport = require "game.entities.spaceport"
  local spaceports = {
    spaceport:new { name = "Alpha" },
    spaceport:new { name = "Bravo" },
    spaceport:new { name = "Charlie" },
  }
  local travel_menu, store
  local mock_store = require "mock_store"
  local action_types = require "game.rules.actions.types"

  before_each(function()
    local menu = require "game.ui.widgets.space_travel_menu"
    store = mock_store({ spaceports = spaceports })
    travel_menu = moonpie.test_render(menu())
  end)


  it("takes a list of destinations and creates buttons for them", function()
    assert.not_nil(travel_menu:find_by_id("goto_Alpha_button"))
    assert.not_nil(travel_menu:find_by_id("goto_Bravo_button"))
    assert.not_nil(travel_menu:find_by_id("goto_Charlie_button"))
  end)

  it("updates location to another station when clicked", function()
    local btn = travel_menu:find_by_id("goto_Bravo_button")
    btn:click()
    assert.is_true(
      moonpie.tables.any(
        store.get_state().actions,
        function(a) return a.type == action_types.location_update end
      )
    )
  end)
end)