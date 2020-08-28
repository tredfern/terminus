-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.game_state.combat", function()
  local combat = require "game.rules.actions.game_state.combat"
  local types = require "game.rules.actions.types"

  it("has the action_type of game_state_change", function()
    local c = combat()
    assert.equals(types.game_state_change, c.type)
    assert.not_nil(c.type)
  end)

  it("has the state of combat", function()
    local c = combat()
    assert.equals("combat", c.payload)
  end)
end)