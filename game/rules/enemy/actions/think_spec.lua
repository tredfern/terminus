-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.enemy.actions.think", function()
  local think = require "game.rules.enemy.actions.think"
  local character = require "game.rules.character"
  local mock_dispatch = require "mock_dispatch"

  it("dispatches a move action to an adjacent square", function()
    local enemy = {
      x = 6,
      y = 9
    }

    spy.on(character.actions, "move")
    local action = think(enemy)
    action(mock_dispatch)

    assert.spy(character.actions.move).was.called()
  end)
end)