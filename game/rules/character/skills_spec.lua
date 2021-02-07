-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.skills", function()
  local skills = require "game.rules.character.skills"
  local attributes = require "game.rules.character.attributes"


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

  it("can define skills", function()
    skills({
      name = "Rifles",
      key = "rifles",
      attribute = attributes.strength
    })

    assert.equals("Rifles", skills.rifles.name)
    assert.equals(attributes.strength, skills.rifles.attribute)
  end)

  it("can calculate the character's base skill", function()
    skills({
      name = "Carousing",
      key = "carousing",
      attribute = attributes.social
    })

    local character = {
      attributes = {
        [attributes.social] = 12
      },
      skills = {
        carousing = 1
      }
    }

    assert.equals(13, skills.carousing(character))
  end)

  it("can have an untrained modified value for skills", function()
    skills {
      name = "Pilot",
      key = "pilot",
      attribute = attributes.education,
      untrained = -4
    }
    local character = {
      attributes = {
        [attributes.education] = 12
      },
      skills = { }
    }

    assert.equals(8, skills.pilot(character))
  end)
end)