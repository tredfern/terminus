-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


describe("game.ui.screens.title", function()
  local title = require "game.ui.screens.title"
  local mock_store = require "mock_store"

  before_each(function()
    mock_store({
      turn = {
        counter = 1
      }
    })
  end)

  it("instantiates a component", function()
    assert.not_nil(title())
  end)

  it("triggers new game on the app if new game is clicked", function()
    local app = require "game.app"
    spy.on(app, "new_game")

    -- instantiate the title component to test it
    local component = title()
    component:find_by_id("new_game_button"):click()
    assert.spy(app.new_game).was.called()
  end)
end)