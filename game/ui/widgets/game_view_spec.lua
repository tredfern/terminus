-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.game_view", function()
  local game_view = require "game.ui.widgets.game_view"
  local mock_store = require "mock_store"
  local mock_view = { id = "mock_view" }

  before_each(function()
    mock_store {
      game_view = {
        current = mock_view
      }
    }
  end)

  it("displays content from game_view state", function()
    local rendered = moonpie.test_render(game_view({ id = "game_view_test" }))
    assert.not_nil(rendered:find_by_id("mock_view"))
  end)

  it("handles when game_view is nil", function()
    mock_store {}
    assert.has_no_errors(function()
      moonpie.test_render(game_view({ id = "game_view_test" }))
    end)
  end)
end)