-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.views.market_view", function()
  local market_view = require "game.ui.views.market_view"

  it("instantiates a component without errors", function()
    assert.not_nil(market_view())
  end)
end)