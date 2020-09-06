-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.game_state_machine", function()
  -- Game State Machine observes when events occur and then sends calls to appropriate modules to handle the situation
  local gamestate = require "game.game_state_machine"
  local events = require "game.rules.events.types"
  local event_system = require "moonpie.event_system"
  local app = require "game.app"

  it("Initializes with the start gamestate ", function()
    gamestate.game_start()
    assert.equals("start", gamestate.current)
  end)


  describe("start combat", function()
    it("monitors for events being triggered to start combat", function()
      gamestate.initialize()
      event_system.dispatch({ type = events.combat_start })
      assert.equals("combat", gamestate.current)
    end)

    it("dispatches to show the combat screen to app", function()
      spy.on(app, "show_combat")
      gamestate.combat_start()
      assert.spy(app.show_combat).was.called()
    end)
  end)
end)