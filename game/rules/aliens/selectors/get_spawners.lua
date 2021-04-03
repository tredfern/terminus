-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  local World = require "game.rules.world"
  return World.selectors.getAllWithComponents(state, "spawner")
end