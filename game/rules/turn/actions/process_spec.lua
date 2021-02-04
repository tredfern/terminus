-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.actions.process", function()
  local process = require "game.rules.turn.actions.process"
  local turn_types = require "game.rules.turn.actions.types"
  local mock_dispatch = require "mock_dispatch"
  local mock_store = require "mock_store"

  local player = { x = 5, y = 3, isPlayerControlled = true, health = 3 }
  local enemy1 = { isPlayerControlled = false, health = 2 }
  local enemy2 = { isPlayerControlled = false, health = 1 }
  local enemy3 = { isPlayerControlled = false, health = 0 }
  local cam = { x = 0, y = 0, width = 20, height = 40 }

  local store = require "moonpie.redux.store"
  before_each(function()
    mock_store {
      characters = {
        enemy2, player, enemy1, enemy3
      },
      camera = cam
    }
  end)

  it("process the supplied character action", function()
    local player_action = { type = "player_action" }

    local action = process(player_action)
    action(mock_dispatch, store.getState)

    assert.is_true(mock_dispatch:received_action("player_action"))
  end)

  it("increments the turn when processed", function()
    local player_action = {}
    local action = process(player_action)

    action(mock_dispatch, store.getState)

    assert.is_true(mock_dispatch:received_action(turn_types.increment))
  end)

  it("triggers thinking for all non-player characters", function()
    local enemy = require "game.rules.enemy"
    spy.on(enemy.actions, "think")

    local action = process({})
    action(mock_dispatch, store.getState)

    assert.spy(enemy.actions.think).was.called(3)
  end)

  it("tracks the camera around the player with player center on screen", function()
    local camera = require "game.ui.camera"
    spy.on(camera.actions, "centerOnPlayer")

    local action = process({})
    action(mock_dispatch, store.getState)

    assert.spy(camera.actions.centerOnPlayer).was.called_with(20, 40)
  end)

  it("removes any dead characters", function()
    local character = require "game.rules.character"
    spy.on(character.actions, "remove")

    local action = process({})
    action(mock_dispatch, store.getState)

    assert.spy(character.actions.remove).was.called_with(enemy3)
  end)

  it("dispatches the game over action if player is dead", function()
    local game_state = require "game.rules.game_state"
    spy.on(game_state.actions, "gameOver")
    player.health = 0
    local action = process({})
    action(mock_dispatch, store.getState)

    assert.spy(game_state.actions.gameOver).was.called()

  end)
end)