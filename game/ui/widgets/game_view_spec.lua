-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.game_view", function()
  local game_view = require "game.ui.widgets.game_view"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local mock_view = { id = "mock_view" }

  before_each(function()
    mockStore {
      game_view = {
        current = mock_view
      }
    }
  end)

  it("displays content from game_view state", function()
    local rendered = moonpie.testRender(game_view({ id = "game_view_test" }))
    assert.not_nil(rendered:findByID("mock_view"))
  end)

  it("handles when game_view is nil", function()
    mockStore {}
    assert.has_no_errors(function()
      moonpie.testRender(game_view({ id = "game_view_test" }))
    end)
  end)
end)