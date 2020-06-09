-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.reducers.player", function()
  local player_reducer = require "game.rules.reducers.player"
  local money_update = require "game.rules.actions.money_update"
  local money_adjust = require "game.rules.actions.money_adjust"

  it("can create an initial state", function()
    local init = player_reducer()
    assert.same(
      { money = 0 },
      init
    )
  end)

  it("can update money to a specific amount", function()
    local init = player_reducer()
    local state = player_reducer(init, money_update(7532))
    assert.equals(7532, state.money)
  end)

  it("can adjust the money up/down by specified amount", function()
    local init = player_reducer()
    local state = player_reducer(init, money_adjust(372))
    assert.equals(372, state.money)
    state = player_reducer(state, money_adjust(-5))
    assert.equals(367, state.money)
  end)
end)