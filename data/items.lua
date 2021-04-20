-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local equipSlots = require "game.rules.character.equip_slots"
local Image = require "moonpie.graphics.image"

Items.describe { key = "sword", name = "Sword", skill = "blade", equipSlot = equipSlots.melee, damage = "1d6" }
Items.describe {
  key = "healthPack",
  name = "Health Pack",
  consumeOnUse = true,
  useHandler = function(_, dispatch, user)
    local Character = require "game.rules.character"
    dispatch(Character.actions.heal(user))
  end,
  image = Image.load("assets/graphics/healthkit.png")
}
Items.describe {
  key = "sprayBottle",
  name = "Anti-Spawn Spray",
  consumeOnUse = false,
  useHandler = function(_, dispatch, user)
    local Aliens = require "game.rules.aliens"
    local store = require "game.store"
    local spawner = Aliens.selectors.getSpawnerAt(store.getState(), user.position)
    if spawner then
      dispatch(Aliens.actions.removeSpawner(spawner))
    end
  end,
  image = Image.load("assets/graphics/spray-bottle.png")
}