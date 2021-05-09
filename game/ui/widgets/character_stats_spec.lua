-- Copyright (c) 2021 Trevor Redfern

--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_stats", function()
  local character_stats = require "game.ui.widgets.character_stats"
  local mockStore = require "moonpie.test_helpers.mock_store"

  before_each(function()
    local character = {
      isPlayerControlled = true,
      name = "Foo",
      health = 15
    }

    mockStore {
      characters = {
        character
      }
    }
  end)

  it("displays the character name", function()
    local testRender = moonpie.testRender(character_stats())
    assert.equals("Foo", testRender:findByID("characterNameValue").text)
  end)

  it("displays the character health", function()
    local testRender = moonpie.testRender(character_stats())
    assert.equals("15", testRender:findByID("characterHealthValue").text)
  end)

end)