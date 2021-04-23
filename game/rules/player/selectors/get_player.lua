-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local getEntities = require "game.rules.world.selectors.get_all_with_components"

return function(state)
  local result = getEntities(state, "isPlayerControlled")
  return result[1]
end