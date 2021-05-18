-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Weapons = {}

function Weapons.sword()
  local Character = require "game.rules.character"
  return {
    key = "sword", name = "Sword", skill = "blade", equipSlot = Character.equipSlots.melee, damage = "1d6"
  }
end

return Weapons