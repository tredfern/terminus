-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.actions.process", function()
  local process = require "game.rules.turn.actions.process"
  local turn_types = require "game.rules.turn.actions.types"
  local mock_dispatch = require "mock_dispatch"
  local mock_store = require "mock_store"

  local player = { x = 5, y = 3, is_player_controlled = true }
  local enemy1 = { is_player_controlled = false }
  local enemy2 = { is_player_controlled = false }
  local enemy3 = { is_player_controlled = false }
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
    action(mock_dispatch, store.get_state)

    assert.is_true(mock_dispatch:received_action("player_action"))
  end)

  it("increments the turn when processed", function()
    local player_action = {}
    local action = process(player_action)

    action(mock_dispatch, store.get_state)

    assert.is_true(mock_dispatch:received_action(turn_types.increment))
  end)

  it("triggers thinking for all non-player characters", function()
    local enemy = require "game.rules.enemy"
    spy.on(enemy.actions, "think")

    local action = process({})
    action(mock_dispatch, store.get_state)

    assert.spy(enemy.actions.think).was.called(3)
  end)

  it("tracks the camera around the player with player center on screen", function()
    local camera = require "game.rules.camera"
    spy.on(camera.actions, "set_position")

    local action = process({})
    action(mock_dispatch, store.get_state)


    assert.spy(camera.actions.set_position).was.called_with(-5, -17)
  end)
end)