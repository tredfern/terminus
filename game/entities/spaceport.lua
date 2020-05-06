-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local spaceport = moonpie.class({})


function spaceport:constructor(props)
  self.name = props.name
  self.trade_goods = {}
end

function spaceport:set_price(trade_good, price)
  self.trade_goods[trade_good] = price
end

function spaceport:get_price(trade_good)
  return self.trade_goods[trade_good]
end

function spaceport:get_available_goods()
  return moonpie.utility.tables.map(self.trade_goods, function(price, good)
    return {
      name = good,
      price = price
    }
  end)
end

return spaceport