-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.character_details", function()
  local CharacterDetails = require "game.ui.screens.character_details"
  local mockStore = require "mock_store"

  before_each(function()
    mockStore {
      characters = {
        { isPlayerControlled = true, name = "My Name" }
      }
    }
  end)

  it("renders a component", function()
    assert.is_table(CharacterDetails())
  end)

  it("can go back to the combat screen", function()
    local app = require "game.app"
    stub(app, "combat")

    local cd = CharacterDetails()
    cd:findByID("btnClose"):click()
    assert.spy(app.combat).was.called()
  end)

  it("displays the character name as the title", function()
    local cd = CharacterDetails()
    assert.equals("My Name", cd:findByID("full_screen_panel_title").text)
  end)

  it("displays the character inventory", function()
    local cd = CharacterDetails()
    assert.not_nil(cd:findByID("characterInventory"))
  end)
end)