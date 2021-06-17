-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat", function()
  local Combat = require "game.rules.combat"

  it("has actions and selectors", function()
    assert.not_nil(Combat.actions)
    assert.not_nil(Combat.selectors)
  end)
end)