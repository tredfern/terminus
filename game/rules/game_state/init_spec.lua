-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state", function()
  local game_state = require "game.rules.game_state"

  it("specifies the actions for the gameState", function()
    assert.not_nil(game_state.actions.checkGameOver)
    assert.not_nil(game_state.actions.gameOver)
    assert.not_nil(game_state.actions.loadCoreData)
    assert.not_nil(game_state.actions.setup)
  end)
end)