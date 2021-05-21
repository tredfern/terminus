-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.isGameLost(state)
  local Player = require "game.rules.player"
  local p = Player.selectors.getPlayer(state)
  return p == nil or p.health <= 0
end

function Selectors.isGameWon(state)
  local Aliens = require "game.rules.aliens"
  local Player = require "game.rules.player"
  local spawners = Aliens.selectors.getSpawners(state)
  local p = Player.selectors.getPlayer(state)

  return #spawners <= 0 and p and p.health > 0
end

return Selectors