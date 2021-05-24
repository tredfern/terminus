-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


describe("game.rules.player.selectors", function()
  local Selectors = require "game.rules.player.selectors"

  describe("SELECTOR: getFieldOfView", function()
    it("finds the player and then gets its FoV", function()
      local player = { isPlayerControlled = true }
      local fov = { }
      local state = {
        world = {
          player
        },
        fieldOfView = {
          [player] = fov
        }
      }

      assert.equals(fov, Selectors.getFieldOfView(state))
    end)
  end)

  describe("SELECTOR: getPlayer", function()
    it("can search state and return the player character if it exists", function()
      local player = { isPlayerControlled = true }
      local state = {
        characters = {
          player
        }
      }

      assert.equals(player, Selectors.getPlayer(state))
    end)
  end)

  describe("SELECTOR: hasItemOfKind", function()
    it("returns true if player inventory has an item of a matching key", function()
      local player = { isPlayerControlled = true, inventory = { { item = { key = "A" } }, { item = { key = "B" } } } }
      local state = { characters = { player } }

      assert.is_true(Selectors.hasItemOfKind(state, "A"))
      assert.is_true(Selectors.hasItemOfKind(state, "B"))
      assert.is_false(Selectors.hasItemOfKind(state, "C"))
    end)
  end)
end)