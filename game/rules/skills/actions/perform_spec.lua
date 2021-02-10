-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.actions.perform", function()
  local perform = require "game.rules.skills.actions.perform"
  local Skills = require "game.rules.skills"

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

    local action = perform(Skills.list.test, character, success)
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

    local action = perform(Skills.list.test, character, success, fail)
    action()
    assert.spy(success).was_not.called()
    assert.spy(fail).was.called()
    assert.equals(2, target)
    assert.in_range(3, 18, roll)
  end)
end)