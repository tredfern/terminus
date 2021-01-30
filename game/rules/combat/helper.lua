-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local helper = { }

function helper.resolve_attack(attack, defense)
  local atk_roll = math.random(100)
  local def_roll = math.random(100)

  return atk_roll <= attack and def_roll > defense, atk_roll, def_roll
end

return helper