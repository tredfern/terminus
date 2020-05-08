-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local starship = moonpie.class({})

function starship:constructor(props)
  props = props or {}
  self.cargo_hold = props.cargo_hold
end

return starship