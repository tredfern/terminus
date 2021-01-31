-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.turn_counter", function()
  local turn_counter = require "game.ui.widgets.turn_counter"
  local mock_store = require "mock_store"
  local moonpie = require "moonpie"

  it("displays the turn number", function()
    mock_store({
      turn = {
        counter = 85
      }
    })

    local render = moonpie.test_render(turn_counter())
    assert.equals("85", render:findByID("turn_counter").text)
  end)
end)