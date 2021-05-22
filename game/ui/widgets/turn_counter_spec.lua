-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.turn_counter", function()
  local turn_counter = require "game.ui.widgets.turn_counter"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local moonpie = require "moonpie"

  it("displays the turn number", function()
    mockStore({
      stats = {
        turnCounter = {
          value = 85
        }
      }
    })

    local render = moonpie.testRender(turn_counter())
    assert.equals("85", render:findByID("turnCounterValue").text)
  end)
end)