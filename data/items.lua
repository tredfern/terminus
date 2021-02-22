-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local equipSlots = require "game.rules.character.equip_slots"
local Image = require "moonpie.graphics.image"

Items.describe { key = "sword", name = "Sword", skill = "blade", equipSlot = equipSlots.melee, damage = "1d6" }
Items.describe { key = "laserGun", name = "Laser Gun", skill = "handgun" }
Items.describe {
  key = "healthPack",
  name = "Health Pack",
  useHandler = function(_, dispatch, user)
    local Character = require "game.rules.character"
    dispatch(Character.actions.heal(user))
  end,
  image = Image.load("assets/graphics/healthkit.png")
}
Items.describe { key = "keycard", name = "Keycard" }