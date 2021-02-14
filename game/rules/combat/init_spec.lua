-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat", function()
  local combat = require "game.rules.combat"

  it("has actions for resolving combat", function()
    assert.not_nil(combat.actions.dealDamage)
    assert.not_nil(combat.actions.meleeAttack)
  end)
end)