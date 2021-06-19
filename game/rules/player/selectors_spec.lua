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
      local player = { isPlayerControlled = true }
      local state = {
        characters = { player },
        inventory = {
          [player] = { carried = { { item = { key = "A" } }, { item = { key = "B" } } } }
        }
      }

      assert.is_true(Selectors.hasItemOfKind(state, "A"))
      assert.is_true(Selectors.hasItemOfKind(state, "B"))
      assert.is_false(Selectors.hasItemOfKind(state, "C"))
    end)
  end)

  describe("SELECTOR: hasVisitedRoom", function()
    it("returns true if the room has already been visited", function()
      local room = {}
      local nope = {}
      local state = {
        player = {
          roomVisits = {
            [room] = true
          }
        }
      }

      assert.is_true(Selectors.hasVisitedRoom(state, room))
      assert.is_falsy(Selectors.hasVisitedRoom(state, nope))
    end)
  end)

  describe("SELECTOR: getHotKeys", function()
    it("returns all the hotkeys from the player state", function()
      local state = {
        player = {
          hotkeys = {
            ["1"] = {},
            ["2"] = {},
            ["ctrl+5"] = {}
          }
        }
      }

      local hotkeys = Selectors.getHotKeys(state)
      assert.not_nil(hotkeys["1"])
      assert.not_nil(hotkeys["2"])
      assert.not_nil(hotkeys["ctrl+5"])
    end)
  end)

  describe("SELECTOR: getHotKey", function()
    it("returns the specific hotkey requested", function()
      local state = {
        player = {
          hotkeys = {
            ["1"] = {}
          }
        }
      }

      assert.is_nil(Selectors.getHotKey(state, "4"))
      assert.is_not_nil(Selectors.getHotKey(state, "1"))
    end)
  end)
end)