-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


describe("game.ui.screens.title", function()
  local title = require "game.ui.screens.title"
  local mock_store = require "mock_store"

  before_each(function()
    mock_store({})
  end)

  it("instantiates a component", function()
    assert.not_nil(title())
  end)
end)