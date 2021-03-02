-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions", function()
  local checkGameOver = require "game.rules.game_state.actions.check_game_over"
  local mockDispatch = require "mock_dispatch"
  local mockStore = require "mock_store"
  local app = require "game.app"

  setup(function()
    mockDispatch.processComplex = true
  end)

  teardown(function()
    mockDispatch.processComplex = false
  end)


  it("triggers the game over action if the player has zero health", function()
    mock(app)
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
    mock(app)
    mockStore({ characters = { {}, {} } }) -- adding a couple "placeholder" characters so not empty

    local action = checkGameOver()
    mockDispatch(action)

    assert.spy(app.gameOver).was.called()
  end)
end)