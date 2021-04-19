-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local World = require "game.rules.world"

return function(state)
  return World.selectors.getAllWithComponents(state, "position", "sprite")
end