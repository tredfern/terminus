-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.combat.actions.deal_damage", function()
  local dealDamage = require "game.rules.combat.actions.deal_damage"
  local mockDispatch = require "mock_dispatch"
  local Character = require "game.rules.character"

  it("adjusts the characters health by a random die roll of the damage", function()
    local character = { health = 10 }
    local action = dealDamage(character, "1d6")
    local newHealth = 0
    local setHealth = spy.new(function(_, h) newHealth = h end)
    Character.actions.setHealth = setHealth

    action(mockDispatch)
    assert.spy(Character.actions.setHealth).was.called_with(character, match.is_number())
    assert.in_range(4, 9, newHealth)
  end)
end)