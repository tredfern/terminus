-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local trade_good = moonpie.class({})

function trade_good:constructor(props)
  self.name = props.name
  self.baseprice = props.baseprice
end


return trade_good