-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.actions.opposed_check.lua", function()
  local mockDispatch = require "mock_dispatch"
  local opposedCheck = require "game.rules.skills.actions.opposed_check"
  local Skills = require "game.rules.skills"
  Skills.describe { key = "diplomacy", attribute = "social" }
  Skills.describe { key = "insight", attribute = "wit" }

  it("the victor wins if they perform better than the defender", function()
    local aggressor = {
      attributes = { social = 12 },
      skills = { diplomacy = 6 }
    }
    local defender = {
      attributes = { wit = 1 },
      skills = { insight = 0 }
    }

    local callback = spy.new(function() end)

    local action = opposedCheck(aggressor, Skills.list.diplomacy, defender, Skills.list.insight, callback)
    action(mockDispatch)

    assert.spy(callback).was_called_with(aggressor, defender)
  end)

  it("the defender wins if they perform better than the aggressor", function()
    local aggressor = {
      attributes = { social = 2 },
      skills = { diplomacy = -6 }
    }
    local defender = {
      attributes = { wit = 17 },
      skills = { insight = 6 }
    }

    local callback = spy.new(function() end)

    local action = opposedCheck(aggressor, Skills.list.diplomacy, defender, Skills.list.insight, callback)
    action(mockDispatch)

    assert.spy(callback).was_called_with(defender, aggressor)
  end)
end)