-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("trade_good_detail", function(props)
  local tg = props.trade_good
  return {
    moonpie.ui.components.text { id = "{{name}}_name", text = tg.name, name = tg.name },
    moonpie.ui.components.text { id = "{{name}}_price", name = tg.name, text = tg.price }
  }
end)

moonpie.ui.components("market", function(props)
  local market = props.market
  local goods = market:get_available_goods()

  return {
    moonpie.utility.tables.map(goods, function(tg)
      return moonpie.ui.components.trade_good_detail{ trade_good = tg }
    end)
  }
end)