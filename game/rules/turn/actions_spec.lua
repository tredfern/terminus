-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.actions", function()
  local Actions = require "game.rules.turn.actions"

  describe("ACTION: process", function()
    local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
    local mockStore = require "moonpie.test_helpers.mock_store"

    local player = { position = { x = 5, y = 3 }, isPlayerControlled = true, health = 3 }
    local enemy1 = { isPlayerControlled = false, health = 2 }
    local enemy2 = { isPlayerControlled = false, health = 1 }
    local enemy3 = { isPlayerControlled = false, health = 0 }
    local cam = { x = 0, y = 0, width = 20, height = 40 }

    local store = require "moonpie.redux.store"
    before_each(function()
      mockStore {
        characters = {
          enemy2, player, enemy1, enemy3
        },
        camera = cam
      }
    end)

    it("process the supplied character action", function()
      local player_action = { type = "player_action" }

      local action = Actions.process(player_action)
      action(mockDispatch, store.getState)

      assert.is_true(mockDispatch:received_action("player_action"))
    end)

    it("triggers thinking for all non-player characters", function()
      local npcs = require "game.rules.npcs"
      spy.on(npcs.actions, "think")

      local action = Actions.process({})
      action(mockDispatch, store.getState)

      assert.spy(npcs.actions.think).was.called(3)
    end)

    it("tracks the camera around the player with player center on screen", function()
      local camera = require "game.ui.camera"
      spy.on(camera.actions, "centerOnPlayer")

      local action = Actions.process({})
      action(mockDispatch, store.getState)

      assert.spy(camera.actions.centerOnPlayer).was.called_with(20, 40)
    end)

    it("removes any dead characters", function()
      local character = require "game.rules.character"
      spy.on(character.actions, "remove")

      local action = Actions.process({})
      action(mockDispatch, store.getState)

      assert.spy(character.actions.remove).was.called_with(enemy3)
    end)

    it("checks the game over state each turn", function()
      local game_state = require "game.rules.game_state"
      spy.on(game_state.actions, "checkGameOver")
      local action = Actions.process({})
      action(mockDispatch, store.getState)

      assert.spy(game_state.actions.checkGameOver).was.called()
    end)

    it("updates the FoV for all sight enabled creatures", function()
      local action = Actions.process({})
      action(mockDispatch, store.getState)

      assert.is_true(mockDispatch:received_action("FIELD_OF_VIEW_CALCULATE_ALL"))
    end)
  end)
end)