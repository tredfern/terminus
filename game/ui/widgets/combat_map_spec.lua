-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.combat_map", function()
  local combat_map = require "game.ui.widgets.combat_map"
  local mockStore = require "moonpie.test_helpers.mock_store"

  it("renders a component", function()
    assert.is_table(combat_map())
  end)

  it("connects to the map state of the store", function()
    local map_state = {}
    mockStore({
      character = {},
      map = map_state,
      fieldOfView = {}
    })

    local cm = combat_map()
    assert.equals(map_state, cm.map)
  end)

  it("connects the camera state to the component", function()
    local camera = {}
    mockStore({
      camera = camera,
      fieldOfView = {}
    })

    local cm = combat_map()
    assert.equals(camera, cm.camera)
  end)

end)