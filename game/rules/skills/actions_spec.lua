-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.actions", function()
  local Actions = require "game.rules.skills.actions"

  describe("ACTION: taskCheck", function()
    local successAction = {}
    local failAction = {}

    it("dispatches the success action on pass", function()
      local action = Actions.taskCheck({ 2, 3, 2 }, successAction, failAction)
      assert.thunk_dispatches(successAction, action)
    end)

    it("dispatches the failure action on fail", function()
      local action = Actions.taskCheck({ -2, -4 }, successAction, failAction)
      assert.thunk_dispatches(failAction, action)
    end)

    it("sends a message about the roll", function()
      local action = Actions.taskCheck({1, 1 }, {}, {})
      assert.thunk_dispatches_type("MESSAGE_LOG_ADD", action)
    end)
  end)
end)