-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local World = require "game.rules.world"
local Character = require "game.rules.character"
local Items = require "game.rules.items"
local Cache = require "game.cache"

return function(state)
  return Cache {
    name = "GET_DRAWABLE_ENTITIES",
    flushOn = {
      World.actions.types.ENTITY_ADD,
      World.actions.types.ENTITY_REMOVE,
      Character.actions.types.ADD,
      Character.actions.types.REMOVE,
      Items.actions.types.ADD,
      Items.actions.types.REMOVE
    },
    source = function()
      return World.selectors.getAllWithComponents(state, "position", "sprite")
    end
  }
end