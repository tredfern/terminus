-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.views.show_market", function()
  local action = require "game.rules.actions.views.show_market"

  it("uses the market widget as the payload for the action", function()
    local act = action()
    assert.equals("market_view", act.payload.name)
  end)
end)