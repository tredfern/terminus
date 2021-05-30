-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Weapons = {}
local equipSlots = require "game.rules.inventory.equip_slots"

function Weapons.sword()
  return {
    key = "sword", name = "Sword", skill = "blade", equipSlot = equipSlots.MELEE, damage = "1d6"
  }
end

return Weapons