-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.basic_information", function()
  local BasicInformation = require "game.ui.create_character.basic_information"
  local Character = require "game.rules.character"
  local Attributes = require "game.rules.character.attributes"
  local testStates = require "test_helpers.test_states"

  local biWidget

  before_each(function()
    biWidget = BasicInformation {
      character = testStates.basicPlayer(),
      buyPoints = 15
    }
  end)

  it("renders a table", function()
    assert.is_table(biWidget)
  end)

  it("updates the character name has it changes", function()
    local character = { }
    local bi = BasicInformation { character = character }
    local nameBox = bi:findByID("characterName")
    assert.component_dispatches(
      Character.actions.setName(character, "Foobar"),
      function()
        nameBox:setText("Foobar")
      end
    )
  end)

  it("sets the minimum and maximum for the attribute spinners", function()
    local intelligenceSpinner = biWidget:findByID("INTELLIGENCESpinner")
    assert.equals(3, intelligenceSpinner.minimum)
    assert.equals(12, intelligenceSpinner.maximum)
  end)

  it("dispatches to increase intelligence attribute", function()
    local spinner = biWidget:findByID("INTELLIGENCESpinner")
    assert.component_dispatches(Character.actions.buyAttributePoint(
      biWidget.character, Attributes.intelligence), function()
        spinner:increase()
      end)
  end)

  it("adds point when points are subtracted", function()
    local spinner = biWidget:findByID("INTELLIGENCESpinner")
    assert.component_dispatches(Character.actions.sellAttributePoint(
      biWidget.character, Attributes.intelligence), function()
        spinner:decrease()
      end)
  end)
end)