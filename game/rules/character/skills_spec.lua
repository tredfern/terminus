-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.skills", function()
  local skills = require "game.rules.character.skills"


  it("create a skill associated with a character attribute", function()
    local character = {
      abilities = {
        agility = 15
      }
    }

    local skill = skills.newSkill(
      "Throwing Stuff",
      character,
      "agility"
    )

    assert.equals("Throwing Stuff", skill.name)
    assert.equals(15, skill:getScore())
  end)
end)