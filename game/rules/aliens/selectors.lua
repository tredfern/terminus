-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local World = require "game.rules.world"

local Selectors = {}

function Selectors.getSpawnerAt(state, position)
  return World.selectors.getByPosition(state, position, "spawner")[1]
end

function Selectors.getSpawners(state)
  return World.selectors.getAllWithComponents(state, "spawner")
end

return Selectors