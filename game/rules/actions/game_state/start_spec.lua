-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.game_state.start", function()
  local start = require "game.rules.actions.game_state.start"
  local action_types = require "game.rules.actions.types"

  it("has the game_state_change action type", function()
    local act = start()
    assert.not_nil(action_types.game_state_change)
    assert.equals(action_types.game_state_change, act.type)
  end)

  it("sets the payload to set the game_state to start", function()
    local act = start()
    assert.equals("start", act.payload)
  end)
end)