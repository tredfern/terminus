-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_skills", function()
  local characterSkills = require "game.ui.widgets.character_skills"
  local Character = require "game.rules.character"

  it("displays all the character skills", function()
    Character.skills { name = "Computers", key = "computers", attribute = Character.attributes.education }
    Character.skills { name = "Mechanics", key = "mechanics", attribute = Character.attributes.education }
    Character.skills { name = "Lock Picking", key = "lockPicking", attribute = Character.attributes.agility }

    local character = {
      attributes = {
        [Character.attributes.education] = 17,
        [Character.attributes.agility] = 12
      },
      skills = {
        computers = 0,
        mechanics = 2,
        lockPicking = 0
      }
    }

    local widget = characterSkills {
      character = character
    }

    assert.equals("17", widget:findByID("computersSkill").text)
    assert.equals("19", widget:findByID("mechanicsSkill").text)
    assert.equals("12", widget:findByID("lockPickingSkill").text)
  end)
end)