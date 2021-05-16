-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"

return function(state, itemType)
  local Player = require "game.rules.player"
  local p = Player.selectors.getPlayer(state)

  return tables.any(p.inventory, function(slot) return slot.item.key == itemType end)
end