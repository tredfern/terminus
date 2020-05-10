-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function buy_click(tg, cargo)
  return function()
    cargo:add_cargo(tg, 1)
    local cargo_hold = moonpie.ui.current.find_by_id("cargo_hold")
    if cargo_hold then
      cargo_hold:update()
    end
  end
end

moonpie.ui.components("trade_good_detail", function(props)
  local cargo = props.cargo_hold
  return {
    moonpie.ui.components.button {
      id = "{{name}}_buy",
      name = props.trade_good.name,
      caption = "<< Buy",
      click = buy_click(props.trade_good, cargo) },
    moonpie.ui.components.text {
      style = "market-good-name",
      id = "{{name}}_name",
      text = props.trade_good.name,
      name = props.trade_good.name },
    moonpie.ui.components.text {
      style = "market-good-price",
      id = "{{name}}_price",
      name = props.trade_good.name,
      text = props.price },
  }
end)

moonpie.ui.components("market", function(props)
  local market = props.market
  local goods = market:get_available_goods()

  return {
    moonpie.utility.tables.map(goods, function(tg)
      return moonpie.ui.components.trade_good_detail{
        trade_good = tg.trade_good,
        price = tg.price,
        cargo_hold = props.cargo_hold
      }
    end)
  }
end)