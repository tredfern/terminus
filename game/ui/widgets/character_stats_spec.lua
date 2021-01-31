-- Copyright (c) 2021 Trevor Redfern

--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_stats", function()
  local character_stats = require "game.ui.widgets.character_stats"
  local mock_store = require "mock_store"

  before_each(function()
    local character = {
      is_player_controlled = true,
      name = "Foo",
      health = 15
    }

    mock_store {
      characters = {
        character
      }
    }
  end)

  it("displays the character name", function()
    local test_render = moonpie.test_render(character_stats())
    assert.equals("Foo", test_render:findByID("character_name").text)
  end)

  it("displays the character health", function()
    local test_render = moonpie.test_render(character_stats())
    assert.equals("15", test_render:findByID("character_health").text)
  end)

end)