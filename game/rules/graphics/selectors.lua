-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local World = require "game.rules.world"
local Character = require "game.rules.character"
local Cache = require "game.cache"

local Selectors = {}

function Selectors.getAnimated(state)
  return World.selectors.getAllWithComponents(state, "animator")
end

function Selectors.getDrawable(state)
  return Cache {
    name = "GET_DRAWABLE_ENTITIES",
    flushOn = {
      World.actions.types.ENTITY_ADD,
      World.actions.types.ENTITY_REMOVE,
      Character.actions.types.ADD,
      Character.actions.types.REMOVE,
    },
    source = function()
      return World.selectors.getAllWithComponents(state, "position", "sprite")
    end
  }
end

return Selectors