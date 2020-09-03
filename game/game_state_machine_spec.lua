-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.game_state_machine", function()
  local gamestate = require "game.game_state_machine"
  local events = require "game.rules.events.types"
  local event_system = require "moonpie.event_system"

  it("Initializes with the start gamestate ", function()
    gamestate.game_start()
    assert.equals("start", gamestate.current)
  end)

  it("monitors for events being triggered to start combat", function()
    gamestate.initialize()
    event_system.dispatch({ type = events.combat_start })
    assert.equals("combat", gamestate.current)
  end)
end)