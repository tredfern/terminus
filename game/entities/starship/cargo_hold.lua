-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local cargo_hold = moonpie.class({})

function cargo_hold:constructor(props)
  self.size = props.size
  self.cargo = {}
end

function cargo_hold:add_cargo(good, quantity)
  if not self.cargo[good] then
    self.cargo[good] = 0
  end
  self.cargo[good] = self.cargo[good] + quantity
end

function cargo_hold:get_cargo_quantity(good)
  return self.cargo[good] or 0
end

return cargo_hold