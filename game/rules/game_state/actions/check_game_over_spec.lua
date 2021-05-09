-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions", function()
  local checkGameOver = require "game.rules.game_state.actions.check_game_over"
  local mockDispatch = require "moonpie.test_helpers.mock_dispatch"
  local mockStore = require "moonpie.test_helpers.mock_store"
  local app = require "game.app"

  setup(function()
    mockDispatch.processComplex = true
  end)

  teardown(function()
    mockDispatch.processComplex = false
  end)

  before_each(function()
    mock(app)
    app.gameOver:clear()
  end)


  it("triggers the game over action if the player has zero health", function()
    mockStore({
      characters = {
        { isPlayerControlled = true, health = 0 }
      }
    })

    local action = checkGameOver()
    mockDispatch(action)

    assert.spy(app.gameOver).was.called()
  end)

  it("triggers the game over action if the player does not exist in the characters state", function()
    mockStore({ characters = { {}, {} } }) -- adding a couple "placeholder" characters so not empty

    local action = checkGameOver()
    mockDispatch(action)

    assert.spy(app.gameOver).was.called()
  end)

  it("triggers the game over action if their are no spawners left on the map", function()
    -- spawner around
    mockStore({
      characters = { { isPlayerControlled = true, health = 10 } },
      world = { { spawner = true } }
    })

    local action = checkGameOver()
    mockDispatch(action)
    assert.spy(app.gameOver).was.not_called()

    -- spawner not around
    mockStore({
      characters = { { isPlayerControlled = true, health = 10 } },
      world = { { } }
    })
    mockDispatch(action)

    assert.spy(app.gameOver).was.called()
  end)
end)