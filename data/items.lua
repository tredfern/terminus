-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local equipSlots = require "game.rules.character.equip_slots"

Items.describe { key = "sword", name = "Sword", skills = { "blade" }, equipSlot = equipSlots.melee }
Items.describe { key = "laserGun", name = "Laser Gun", skills = { "handgun" } }
Items.describe { key = "healthPack", name = "Health Pack" }
Items.describe { key = "keycard", name = "Keycard" }