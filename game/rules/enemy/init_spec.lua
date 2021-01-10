-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.enemy", function()
  local enemy = require "game.rules.enemy"

  it("has a think action", function()
    assert.not_nil(enemy.actions.think)
  end)
end)