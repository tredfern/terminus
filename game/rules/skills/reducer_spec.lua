-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.skills.reducer", function()
  local reducer = require "game.rules.skills.reducer"
  local types = require "game.rules.skills.types"

  describe("ACTION: define", function()
    it("adds a skill to the key slot defined for the skill", function()
      local action = {
        type = types.DEFINE,
        payload = {
          name = "Throw",
          key = "throw",
          ability = "STRENGTH",
          untrainedPenalty = -3
        }
      }

      local state = reducer({}, action)
      assert.equals("Throw", state["throw"].name)
      assert.equals("STRENGTH", state["throw"].ability)
      assert.equals(-3, state["throw"].untrainedPenalty)
    end)
  end)
end)