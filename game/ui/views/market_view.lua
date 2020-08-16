-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local panel = require "game.ui.widgets.panel"
local market = require "game.ui.widgets.market"

return components("market_view", function()
  return {
    id = "market_view",
    panel {
      style = "panel_yellow",
      title = "Market",
      contents = market()
    }
  }
end)