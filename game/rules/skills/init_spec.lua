-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills", function()
  local Skills = require "game.rules.skills"

  describe("skill list", function()
    assert.not_nil(Skills.list.unarmed)
    assert.not_nil(Skills.list.sword)
    assert.not_nil(Skills.list.dodge)
  end)

  it("has skill actions", function()
    assert.not_nil(Skills.actions.opposedCheck)
    assert.not_nil(Skills.actions.perform)
  end)

  it("can choose skills for different situations", function()
    assert.not_nil(Skills.chooseSkill)
  end)
end)