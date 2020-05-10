-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

moonpie.ui.components("trade_good_detail", function(props)
  local cargo = props.cargo_hold
  local quantity_control = moonpie.ui.components.text {
    id = "{{name}}_player_quantity",
    name = props.trade_good.name,
    text = cargo:get_cargo_quantity(props.trade_good),
    style = "market-good-price",
  }
  return {
    quantity_control,
    moonpie.ui.components.button {
      id = "{{name}}_buy",
      name = props.trade_good.name,
      caption = "<< Buy",
      click = function()
        cargo:add_cargo(props.trade_good, 1)
        quantity_control:update { text = cargo:get_cargo_quantity(props.trade_good) }
      end
    },
    moonpie.ui.components.button {
      id = "{{name}}_sell",
      name = props.trade_good.name,
      caption = "Sell >>",
      click = function()
        cargo:remove_cargo(props.trade_good, 1)
        quantity_control:update { text = cargo:get_cargo_quantity(props.trade_good) }
      end
    },
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