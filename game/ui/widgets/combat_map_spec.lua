-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.combat_map", function()
  local combat_map = require "game.ui.widgets.combat_map"
  local mock_store = require "mock_store"

  it("renders a component", function()
    assert.is_table(combat_map())
  end)

  it("connects to the characters state of the store", function()
    local c = {}
    mock_store({ characters = { c }})
    local map = combat_map()
    assert.same({ c }, map.characters)
  end)

  it("connects to the map state of the store", function()
    local map_state = {}
    mock_store({
      character = {},
      map = map_state
    })

    local cm = combat_map()
    assert.equals(map_state, cm.map)
  end)

end)