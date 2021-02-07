-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.skills", function()
  local skills = require "game.rules.character.skills"
  local attributes = require "game.rules.character.attributes"

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

  it("has some basic skills set up", function()
    assert.not_nil(skills.unarmed)
    assert.not_nil(skills.blade)
    assert.not_nil(skills.handgun)
    assert.not_nil(skills.throwing)
  end)
end)