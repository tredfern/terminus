-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_skills", function()
  local characterSkills = require "game.ui.widgets.character_skills"
  local Skills = require "game.rules.skills"
  local Character = require "game.rules.character"

  it("displays all the character skills", function()
    Skills.describe { name = "Computers", key = "computers", attribute = Character.attributes.education }
    Skills.describe { name = "Mechanics", key = "mechanics", attribute = Character.attributes.education }
    Skills.describe { name = "Lock Picking", key = "lockPicking", attribute = Character.attributes.agility }

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

    assert.equals("17", widget:findByID("computersValue").text)
    assert.equals("19", widget:findByID("mechanicsValue").text)
    assert.equals("12", widget:findByID("lockPickingValue").text)
  end)
end)