-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.selectors", function()
  local Selectors = require "game.rules.skills.selectors"
  local Attributes = require "game.rules.character.attributes"

  describe("SELECTOR: getCharacterSkills", function()
    it("returns the character attribute score for the skill if character has no training", function()
      local character = {
        attributes = {
          [Attributes.strength] = 3,
          [Attributes.dexterity] = 2
        }
      }
      local skillList = Selectors.getCharacterSkills({}, character)
      assert.equals(3, skillList.unarmed)
      assert.equals(2, skillList.sword)
      assert.equals(2, skillList.dodge)
    end)
  end)

  describe("SELECTOR: getSkillValue", function()
    it("returns the value of a specific skill", function()
      local character = {
        attributes = {
          [Attributes.strength] = 7
        }
      }

      assert.equals(7, Selectors.getSkillValue({}, character, "unarmed"))
    end)
  end)

  describe("SELECTOR: getSkillModifier", function()
    it("returns skill points if the skill is in the characters list", function()
      local c = {
        skills = {
          unarmed = 1
        }
      }

      assert.equals(1, Selectors.getSkillModifier({}, c, "unarmed"))
    end)

    it("returns -3 if the character has no skill points", function()
      local c = { skills = { } }
      assert.equals(-3, Selectors.getSkillModifier({}, c, "unarmed"))
    end)
  end)

  describe("SELECTOR: getSkillBaseAttribute", function()
    it("returns the skill's Base Attribute from the skill name", function()
      local attributes = require "game.rules.character.attributes"
      assert.equals(attributes.strength, Selectors.getSkillBaseAttribute({}, "unarmed"))
    end)
  end)
end)