-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.actions.increment", function()
  local increment = require "game.rules.turn.actions.increment"
  local types = require "game.rules.turn.actions.types"

  it("has a type to increment the counter", function()
    local action = increment()
    assert.not_nil(action.type)
    assert.equals(types.INCREMENT, action.type)
  end)
end)