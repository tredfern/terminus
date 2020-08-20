-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.character_creation", function()
  local character_creation = require "game.ui.screens.character_creation"
  local mock_store = require "mock_store"

  before_each(function()
    mock_store {
      player = {
        name = "Cadet Space"
      }
    }
  end)

  it("instantiates a component", function()
    assert.not_nil(character_creation())
  end)
end)