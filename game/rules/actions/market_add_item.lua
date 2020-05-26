-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.actions.types"
return function(name, price)
  return {
    type = types.market_add_item,
    payload = {
      name = name,
      price = price
    }
  }
end