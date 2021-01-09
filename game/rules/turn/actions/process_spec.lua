-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.turn.actions.process", function()
  local process = require "game.rules.turn.actions.process"
  local mock_dispatch = require "mock_dispatch"

  it("process the supplied character action", function()
    local player_action = { type = "player_action" }

    local action = process(player_action)
    action(mock_dispatch)

    assert.is_true(mock_dispatch:received_action("player_action"))
  end)
end)