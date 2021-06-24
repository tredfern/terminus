-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local ImageManager = require "game.rules.graphics.image_manager"
local Gear = {}

function Gear.healthPack()
  return {
    key = "healthPack",
    name = "Health Pack",
    consumeOnUse = true,
    useHandler = function(_, dispatch, user)
      local Character = require "game.rules.character"
      dispatch(Character.actions.heal(user))
    end,
    sprite = ImageManager.load("HEALTH_PACK", "assets/graphics/healthkit.png"),
    item = true
  }
end

function Gear.sprayBottle()
  return {
    key = "sprayBottle",
    name = "Anti-Spawner Spray",
    consumeOnUse = false,
    useHandler = function(_, dispatch, user)
      local Aliens = require "game.rules.aliens"
      local store = require "game.store"
      local spawner = Aliens.selectors.getSpawnerAt(store.getState(), user.position)
      if spawner then
        dispatch(Aliens.actions.removeSpawner(spawner))
      end
    end,
    sprite = ImageManager.load("SPRAY_BOTTLE", "assets/graphics/spray-bottle.png"),
    item = true
  }
end

function Gear.keycard()
   return {
    key = "keycard",
    name = "Keycard",
    sprite = ImageManager.load("KEY_CARD", "assets/graphics/keycard.png"),
    item = true
  }
end

return Gear