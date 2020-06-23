-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.main_layout", function()
  local market = require "game.ui.screens.main_layout"
  local mock_store = require "mock_store"

  before_each(function()
    mock_store {
      location = { name = "The Large Area" }
    }
  end)

  it("instantiates successfully", function()
    assert.not_nil(market())
  end)

end)