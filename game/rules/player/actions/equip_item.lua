-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local getPlayer = require "game.rules.player.selectors.get_player"
local Characters = require "game.rules.character"
local store = require "game.store"

return function(item)
  local player = getPlayer(store.getState())
  return Characters.actions.equipItem(player, item)
end