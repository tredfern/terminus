-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills", function()
  local Skills = require "game.rules.skills"
  local attributes = require "game.rules.character.attributes"

  it("can define skills", function()
    Skills.describe({
      name = "Rifles",
      key = "rifles",
      attribute = attributes.strength
    })

    assert.equals("Rifles", Skills.list.rifles.name)
    assert.equals(attributes.strength, Skills.list.rifles.attribute)
  end)

  it("can calculate the character's base skill", function()
    Skills.describe({
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

    assert.equals(13, Skills.list.carousing(character))
  end)

  it("can have an untrained modified value for skills", function()
    Skills.describe {
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

    assert.equals(8, Skills.list.pilot(character))
  end)

  it("has skill actions", function()
    assert.not_nil(Skills.actions.perform)
  end)
end)