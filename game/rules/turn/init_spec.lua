-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn", function()
  local turn = require "game.rules.turn"

  it("has action to process turns", function()
    assert.is_not_nil(turn.actions.process)
  end)
end)