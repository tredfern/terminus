-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local SpecialAttacks = require "game.rules.combat.special_attacks"
local Selectors = {}

function Selectors.getMeleeWeapon(state, character)
  local Inventory = require "game.rules.inventory"
  local weapon = Inventory.selectors.getEquippedItem(state, character, Inventory.equipSlots.melee)

  if weapon == nil then
    return SpecialAttacks.unarmed
  end

  return weapon
end

return Selectors