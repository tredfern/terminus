-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local function buy_click(tg, cargo)
  return function()
    cargo:add_cargo(tg, 1)
    local id = tg .. "_player_quantity"
    local quantity = moonpie.ui.current.find_by_id(id)
    if quantity then
      quantity:update { text = cargo:get_cargo_quantity(tg) }
    else
      moonpie.logger.debug("quantity component not found: %s", id)
    end
  end
end

moonpie.ui.components("trade_good_detail", function(props)
  local tg = props.trade_good
  local cargo = props.cargo_hold
  return {
    moonpie.ui.components.text {
      style = "market-good-price",
      id = "{{name}}_player_quantity",
      text = "{{quantity}}", name = tg.name, quantity = cargo:get_cargo_quantity(tg) },
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