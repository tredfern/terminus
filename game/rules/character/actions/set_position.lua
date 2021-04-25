-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.character.actions.types"
local map = require "game.rules.map"
local World = require "game.rules.world"
local tables = require "moonpie.tables"

return function(character, position)
  return {
    type = types.SET_POSITION,
    payload = {
      character = character,
      position = position
    },
    validate = function(_, state)
      local terrain = map.selectors.getTerrain(state, position)
      if terrain.blocksMovement then return false end

      -- search entities
      local entities = World.selectors.getByPosition(state, position)
      if not tables.isEmpty(entities) then
        return not tables.any(entities, function(e) return e.blocksMovement end)
      end

      return true
    end
  }
end