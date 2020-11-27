-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.game_state_machine", function()
  -- Game State Machine observes when events occur and then sends calls to appropriate modules to handle the situation
  local gamestate = require "game.game_state_machine"

  it("Initializes with the start gamestate ", function()
    gamestate.game_start()
    assert.equals("start", gamestate.current)
  end)

end)