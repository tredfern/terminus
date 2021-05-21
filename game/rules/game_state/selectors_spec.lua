-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.selectors", function()
  local Selectors = require "game.rules.game_state.selectors"

  describe("SELECTOR: isGameLost", function()
    it("returns false if the player is still alive", function()
      local state = { characters = { { isPlayerControlled = true, health = 10 } } }
      assert.is_false(Selectors.isGameLost(state))
    end)

    it("triggers the game over action if the player has zero health", function()
      local state = { characters = { { isPlayerControlled = true, health = 0 } } }
      assert.is_true(Selectors.isGameLost(state))
    end)

    it("triggers the game over action if the player does not exist in the characters state", function()
      local state = { characters = { {}, {} } }
      assert.is_true(Selectors.isGameLost(state))
    end)
  end)

  describe("SELECTOR: isGameWon", function()
    it("false if the player is alive with spawners on the map", function()
      local state = {
        characters = { { isPlayerControlled = true, health = 10 } },
        world = { { spawner = true } }
      }
      assert.is_false(Selectors.isGameWon(state))
    end)

    it("true if the player is alive without spawners on the map", function()
      local state = {
        characters = { { isPlayerControlled = true, health = 10 } },
        world = { { } }
      }
      assert.is_true(Selectors.isGameWon(state))
    end)
  end)
end)