-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.basic_information", function()
  local BasicInformation = require "game.ui.create_character.basic_information"
  local Character = require "game.rules.character"

  it("renders a table", function()
    assert.is_table(BasicInformation { character = {} })
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
end)