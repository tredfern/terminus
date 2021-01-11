-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_stats", function()
  local character_stats = require "game.ui.widgets.character_stats"
  local mock_store = require "mock_store"

  it("displays the character name", function()
    local character = {
      is_player_controlled = true,
      name = "Foo"
    }

    mock_store {
      characters = {
        character
      }
    }

    local test_render = moonpie.test_render(character_stats())
    assert.equals("Foo", test_render:find_by_id("character_name").text)
  end)

end)