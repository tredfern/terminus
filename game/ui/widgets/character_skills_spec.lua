-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_skills", function()
  local characterSkills = require "game.ui.widgets.character_skills"

  it("displays all the character skills", function()
    local character = {
      skills = {
        computers = { name = "Computers", getScore = function() return 17 end },
        mechanics = { name = "Mechanics", getScore = function() return 19 end },
        lockPicking = { name = "Lock picking", getScore = function() return 12 end },
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