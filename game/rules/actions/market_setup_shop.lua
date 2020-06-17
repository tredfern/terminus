-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local trade_goods = require "assets.trade_goods"
local market_add_item = require "game.rules.actions.market_add_item"
local market_prices = require "game.rules.helpers.market_prices"

return function()
  return function(dispatch)
    for _, v in ipairs(trade_goods) do
      dispatch(market_add_item(v.name, market_prices.random(v.baseprice)))
    end
  end
end