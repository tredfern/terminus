-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state", function()
  local game_state = require "game.rules.game_state"

  it("has an action to setup the game", function()
    assert.not_nil(game_state.actions.setup)
  end)

  it("has an action to end the game", function()
    assert.not_nil(game_state.actions.game_over)
  end)
end)