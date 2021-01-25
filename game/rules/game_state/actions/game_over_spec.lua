-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.game_state.actions.game_over", function()
  local game_over = require "game.rules.game_state.actions.game_over"
  local app = require "game.app"

  it("returns to the title screen", function()
    mock(app)
    local go = game_over()
    go()
    assert.spy(app.title).was.called()
  end)
end)