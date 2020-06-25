-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.action_menu", function()
  local action_menu = require "game.ui.widgets.action_menu"
  local mock_store = require "mock_store"
  local spied = spy.new(function() end)

  before_each(function()
    mock_store {
      game_view = {
        actions = {
          { text = "Do thing", action = spied },
          { text = "Do other thing", action = spied },
          { text = "Do last thing", action = spied }
        }
      }
    }
  end)

  it("can render an empty list of actions", function()
    mock_store({})
    assert.has_no_errors(function() moonpie.test_render(action_menu()) end)
  end)

  it("takes a list of actions with corresponding events attached", function()
    local cm = moonpie.test_render(action_menu())

    assert.not_nil(cm:find_by_id("action_menu_item_1"))
    cm:find_by_id("action_menu_item_2"):click()
    assert.spy(spied).was.called()
  end)
end)