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
  local Inventory = require "game.rules.inventory"
  local p = Selectors.getPlayer(state)
  local inv = Inventory.selectors.getInventory(state, p)

  return tables.any(inv.carried, function(slot) return slot.item.key == itemType end)
  -- return Inventory.selectors.isCarryingItem(state, p, itemType)
end


function Selectors.getFieldOfView(state)
  local FOV = require "game.rules.field_of_view"

  local p = Selectors.getPlayer(state)
  return FOV.selectors.get(state, p)
end

function Selectors.getFreeHotKey(state)
  local HOTKEYS = require "game.rules.player.hotkeys"

  for _, v in ipairs(HOTKEYS) do
    if Selectors.getHotKey(state, v) == nil then
      return v
    end
  end
end

function Selectors.getHotKeys(state)
  if state.player and state.player.hotkeys then
    return state.player.hotkeys
  end
end

function Selectors.getHotKey(state, hotkey)
  if not state.player or not state.player.hotkeys then
    return nil
  end

  return state.player.hotkeys[hotkey]
end

function Selectors.getPosition(state)
  local player = Selectors.getPlayer(state)
  return player.position
end

function Selectors.hasVisitedRoom(state, room)
  if state and state.player and state.player.roomVisits then
    return state.player.roomVisits[room]
  end
end

return Selectors