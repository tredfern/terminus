-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.character_details", function()
  local CharacterDetails = require "game.ui.character_details"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local Position = require "game.rules.world.position"

  before_each(function()
    local player = { isPlayerControlled = true, name = "My Name", position = Position(1, 1, 1) }
    local inventory = {}
    mockStore {
      characters = { player },
      inventory = {
        [player] = inventory
      }
    }
  end)

  it("renders a component", function()
    assert.is_table(CharacterDetails())
  end)

  it("can go back to the combat screen", function()
    local app = require "game.app"
    stub(app, "mainScreen")

    local cd = CharacterDetails()
    cd:findByID("btnClose"):click()
    assert.stub(app.mainScreen).was.called()
    app.mainScreen:revert()
  end)

  it("displays the character name as the title", function()
    local cd = CharacterDetails()
    assert.equals("My Name", cd:findByID("full_screen_panel_title_text").text)
  end)

  it("displays the character inventory", function()
    local cd = CharacterDetails()
    assert.not_nil(cd:findByID("characterInventory"))
  end)

  it("displays the equipped items", function()
    local cd = CharacterDetails()
    assert.not_nil(cd:findByID("characterEquipment"))
  end)

  it("closes the screen if tab is pressed", function()
    local app = require "game.app"
    stub(app, "mainScreen")

    local cd = CharacterDetails()
    cd:mounted()

    local Keyboard = require "moonpie.keyboard"
    Keyboard:keyPressed("tab")

    assert.stub(app.mainScreen).was.called()
    app.mainScreen:revert()
  end)
end)