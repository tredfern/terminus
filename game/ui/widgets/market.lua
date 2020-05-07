-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function buy_click(tg, cargo)
  return function()
    cargo:add_cargo(tg, 1)
  end
end

moonpie.ui.components("trade_good_detail", function(props)
  local tg = props.trade_good
  local cargo = props.cargo_hold
  return {
    moonpie.ui.components.text {
      style = "market-good-price",
      id = "{{name}}_player_quantity",
      text = "0", name = tg.name },
    moonpie.ui.components.button {
      id = "{{name}}_buy",
      name = tg.name,
      caption = "<< Buy",
      click = buy_click(tg.name, cargo) },
    moonpie.ui.components.text {
      style = "market-good-name",
      id = "{{name}}_name",
      text = tg.name,
      name = tg.name },
    moonpie.ui.components.text {
      style = "market-good-price",
      id = "{{name}}_price",
      name = tg.name,
      text = tg.price },
    moonpie.ui.components.button { caption = "Sell >>" },
  }
end)

moonpie.ui.components("market", function(props)
  local market = props.market
  local goods = market:get_available_goods()

  return {
    moonpie.utility.tables.map(goods, function(tg)
      return moonpie.ui.components.trade_good_detail{ trade_good = tg, cargo_hold = props.cargo_hold }
    end)
  }
end)