-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.player_stats", function()
  local player_stats = require "game.ui.widgets.player_stats"
  local mock_store = require "mock_store"
  local rendered

  before_each(function()
    mock_store({
      player = {
        money = 175
      }
    })
    rendered = moonpie.test_render(player_stats())
  end)

  it("tracks the money available to the player", function()
    assert.equals("175", rendered:find_by_id("player_money").text)
  end)
end)