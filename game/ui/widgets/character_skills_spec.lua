-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_skills", function()
  local characterSkills = require "game.ui.widgets.character_skills"
  local Skills = require "game.rules.skills"
  local Character = require "game.rules.character"

  it("displays all the character skills", function()
    Skills.list.computers = { name = "Computers", key = "computers", attribute = Character.attributes.education }
    Skills.list.mechanics = { name = "Mechanics", key = "mechanics", attribute = Character.attributes.education }
    Skills.list.lockPicking = { name = "Lock Picking", key = "lockPicking", attribute = Character.attributes.agility }

    local widget = characterSkills {
      characterSkills = {
        computers = 17,
        mechanics = 17,
        lockPicking = 12
      }
    }

    assert.equals("17", widget:findByID("computersValue").text)
    assert.equals("17", widget:findByID("mechanicsValue").text)
    assert.equals("12", widget:findByID("lockPickingValue").text)
  end)
end)