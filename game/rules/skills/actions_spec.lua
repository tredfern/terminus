-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.actions", function()
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local Actions = require "game.rules.skills.actions"
  local Skills = require "game.rules.skills"

  describe("ACTION: opposedCheck", function()
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

      local action = Actions.opposedCheck(aggressor, Skills.list.diplomacy, defender, Skills.list.insight, callback)
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

      local action = Actions.opposedCheck(aggressor, Skills.list.diplomacy, defender, Skills.list.insight, callback)
      action(mockDispatch)

      assert.spy(callback).was_called_with(defender, aggressor)
    end)
  end)

  describe("ACTION: perform", function()
    Skills.describe { name = "Test", key = "test", attribute = "strength" }
    local target, roll, success, fail

    before_each(function()
      success = spy.new(function(a, b) target = a; roll = b; end)
      fail = spy.new(function(a, b) target = a; roll = b; end)
    end)

    it("on a successful skill check, it calls the success result", function()
      local character = {
        attributes = {
          strength = 15
        },
        skills = {
          test = 3
        }
      }

      local action = Actions.perform(Skills.list.test, character, success)
      action()
      assert.spy(success).was.called()
      assert.spy(fail).was_not.called()
      assert.equals(18, target)
      assert.in_range(3, 18, roll)
    end)

    it("calls the failure call back when the skill fails", function()
      local character = {
        attributes = {
          strength = 3
        },
        skills = {
          test = -1
        }
      }

      local action = Actions.perform(Skills.list.test, character, success, fail)
      action()
      assert.spy(success).was_not.called()
      assert.spy(fail).was.called()
      assert.equals(2, target)
      assert.in_range(3, 18, roll)
    end)
  end)
  end)