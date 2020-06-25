-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "moonpie.ui.components"
local market = require "game.ui.widgets.market"

return components("market_view", function()
  return {
    components.h3 { text = "Market" },
    components.hr(),
    {
      market()
    },
  }
end)