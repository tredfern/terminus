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

  it("can perform skill checks", function()
    local mockRandom = require "moonpie.test_helpers.mock_random"

    mockRandom.setreturnvalues { 15, 12, 11, 18 , 19}

    local character = {
      abilities = {
        agility = 15
      }
    }
    local skill = skills.newSkill("Billiards", character, "agility")
    assert.is_true(skills.performCheck(skill))
    assert.is_true(skills.performCheck(skill))
    assert.is_true(skills.performCheck(skill))
    assert.is_false(skills.performCheck(skill))
    local success, roll = skills.performCheck(skill)

    assert.is_false(success)
    assert.equals(19, roll)

  end)
end)