-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.spaceport_add", function()
  local action_types = require "game.rules.actions.types"
  local action_creator = require "game.rules.actions.spaceport_add"

  it("creates an action that specifies the spaceport properties", function()
    local action = action_creator{ name = "Alphabase" }
    assert.equals(action_types.spaceport_add, action.type)
    assert.same({ name = "Alphabase" }, action.payload)
  end)
end)