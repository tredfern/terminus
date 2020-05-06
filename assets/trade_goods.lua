-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tradegood = require "game.entities.trade_good"
return {
  organics = tradegood:new{ name = "Organics", baseprice = 5 },
  ship_parts = tradegood:new{ name = "Ship Parts", baseprice = 10 },
  luxury_items = tradegood:new{ name = "Luxury Items", baseprice = 25 },
  contraband = tradegood:new{ name = "Contraband", baseprice = 45 },
  computers = tradegood:new{ name = "Computers", baseprice = 15 }
}