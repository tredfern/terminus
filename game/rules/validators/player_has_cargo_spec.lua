-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.validators.player_has_cargo", function()
  local player_has_cargo = require "game.rules.validators.player_has_cargo"

  it("returns true if the player has cargo specified by name at certain amount", function()
    local state = {
      player_cargo = {
        ["Pets"] = { quantity = 7 }
      }
    }

    assert.is_true(player_has_cargo(state, "Pets"))
    assert.is_true(player_has_cargo(state, "Pets", 5))
    assert.is_false(player_has_cargo(state, "Pets", 8))
  end)

  it("ensures at least 1 if no quantity is specified", function()
    local state = {
      player_cargo = {
        ["Food"] = { quantity = 0 },
        ["Water"] = { quantity = 1 }
      }
    }

    assert.is_false(player_has_cargo(state, "Food"))
    assert.is_true(player_has_cargo(state, "Water"))
  end)
end)