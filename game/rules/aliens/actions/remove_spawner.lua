-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


return function(spawner)
  local World = require "game.rules.world"
  return World.actions.removeEntity(spawner)
end