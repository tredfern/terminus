-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Weapons = {}
local equipSlots = require "game.rules.inventory.equip_slots"

function Weapons.sword()
  return {
    key = "sword", name = "Sword", skill = "blade", equipSlot = equipSlots.melee, damage = "1d6"
  }
end

function Weapons.laserRifle()
  return {
    key = "laser_rifle", name = "Laser Rifle", equipSlot = equipSlots.ranged, damage = "1d6"
  }
end

return Weapons