-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character.general", function()
  local character_general = require "game.ui.widgets.character.general"
  local mock_store = require "mock_store"
  local rendered

  before_each(function()
    mock_store {
      player = {
        name = "Cmdr. Cheesepuff"
      }
    }
    rendered = moonpie.test_render(character_general())
  end)

  it("renders a components", function()
    assert.not_nil(character_general())
  end)

  it("displays the name of the character", function()
    local name = rendered:find_by_id("character_name")
    assert.equals("Cmdr. Cheesepuff", name:value())
  end)
end)