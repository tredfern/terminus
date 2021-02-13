-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.choose_skill", function()
  local Skills = require "game.rules.skills"
  local chooseSkill = require "game.rules.skills.choose_skill"

  Skills.describe { key = "blade", attribute = "agility" }

  it("can choose the best skill to use for a melee weapon", function()
    local weapon = { skill = "blade" }
    local character = { skills = { blade = 12 } }

    assert.equals(Skills.list.blade, chooseSkill.forItem(character, weapon))
  end)
end)