-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local World = require "game.rules.world"
local Cache = require "game.cache"

local Selectors = {}

function Selectors.getPlayer(state)
  return Cache {
    name = "GET_PLAYER",
    source = function()
      local result = World.selectors.getAllWithComponents(state, "isPlayerControlled")
      return result[1]
    end
  }
end

function Selectors.hasItemOfKind(state, itemType)
  local p = Selectors.getPlayer(state)

  return tables.any(p.inventory, function(slot) return slot.item.key == itemType end)
end


function Selectors.getFieldOfView(state)
  local FOV = require "game.rules.field_of_view"

  local p = Selectors.getPlayer(state)
  return FOV.selectors.get(state, p)
end

function Selectors.hasVisitedRoom(state, room)
  if state and state.player and state.player.roomVisits then
    return state.player.roomVisits[room]
  end
end

return Selectors