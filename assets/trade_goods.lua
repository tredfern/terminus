-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tradegood = require "game.entities.trade_good"
return {
  tradegood:new{ name = "Organics", baseprice = 5 },
  tradegood:new{ name = "Ship Parts", baseprice = 10 },
  tradegood:new{ name = "Luxury Items", baseprice = 25 },
  tradegood:new{ name = "Contraband", baseprice = 45 },
  tradegood:new{ name = "Computers", baseprice = 15 }
}