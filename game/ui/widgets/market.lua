-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local connect = require "moonpie.redux.connect"
local market_buy = require "game.rules.actions.market_buy"
local market_sell = require "game.rules.actions.market_sell"
local tables = require "moonpie.tables"

local trade_good_item = moonpie.ui.components("trade_good_detail", function(props)
  return {
    display = "inline-block",
    moonpie.ui.components.button {
      id = "{{name}}_buy",
      name = props.item_name,
      caption = "Buy",
      click = props.buy
    },
    moonpie.ui.components.button {
      id = "{{name}}_sell",
      name = props.item_name,
      caption = "Sell",
      click = props.sell
    },
    moonpie.ui.components.text {
      style = "market-good-name",
      id = "{{name}}_name",
      text = props.item_name,
      name = props.item_name },
    moonpie.ui.components.text {
      style = "market-good-price",
      id = "{{name}}_price",
      name = props.item_name,
      text = props.price },
  }
end)

local market = moonpie.ui.components("market", function(props)
  return {
    market_items = props.market_items,
    render = function(self)
      local sorted_items = tables.sort_by(self.market_items, function(_, v) return v.name end)
      return tables.map(sorted_items, function(tg)
        return trade_good_item{
          item_name = tg.value.name,
          price = tg.value.price,
          buy = function() self.dispatch(market_buy(tg.value.name, tg.value.price)) end,
          sell = function() self.dispatch(market_sell(tg.value.name, tg.value.price)) end
        }
      end)
    end
  }
end)


return connect(market, function(state) return { market_items = state.market_items } end)