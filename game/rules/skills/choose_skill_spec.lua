-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.choose_skill", function()
  local Skills = require "game.rules.skills"
  local chooseSkill = require "game.rules.skills.choose_skill"

  Skills.list.blade = { key = "blade", attribute = "agility" }
  Skills.list.dodge = { key = "dodge", attribute = "agility" }

  it("can choose the best skill to use for a melee weapon", function()
    local weapon = { skill = "blade" }
    local character = { skills = { blade = 12 } }

    assert.equals(Skills.list.blade, chooseSkill.forItem(character, weapon))
  end)

  it("can choose the best defensive skill for melee attack", function()
    local character = { skills = { dodge = 12 } }

    assert.equals(Skills.list.dodge, chooseSkill.forMeleeDefense(character))
  end)
end)