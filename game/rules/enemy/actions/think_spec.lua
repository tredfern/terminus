-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.enemy.actions.think", function()
  local think = require "game.rules.enemy.actions.think"
  local mockDispatch = require "mock_dispatch"


  it("calls the ai routine for the enemy", function()
    local enemy = {
      ai = spy.new(function() end)
    }
    local getState = function() end
    local action = think(enemy)
    action(mockDispatch, getState)

    assert.spy(enemy.ai).was.called_with(enemy, mockDispatch, getState)
  end)
end)