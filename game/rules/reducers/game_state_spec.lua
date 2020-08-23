-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.reducers.game_state", function()
  local game_state = require "game.rules.reducers.game_state"
  local types = require "game.rules.actions.types"


  it("handles nil actions", function()
    local s = {}
    assert.equals(s, game_state(s))
  end)

  it("sets the current state to the new state on a change action", function()
    local state = game_state({}, { type = types.game_state_change, payload = "start" })
    assert.equals("start", state.current)
  end)

  it("handles when state is nil", function()
    local state = game_state(nil, { type = types.game_state_change, payload = "start" })
    assert.equals("start", state.current)
  end)
end)