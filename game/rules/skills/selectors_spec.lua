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
end)