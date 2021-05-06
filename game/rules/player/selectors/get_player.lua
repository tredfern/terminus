-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local getEntities = require "game.rules.world.selectors.get_all_with_components"
local Cache = require "game.cache"

return function(state)
  return Cache {
    name = "GET_PLAYER",
    source = function()
      local result = getEntities(state, "isPlayerControlled")
      return result[1]
    end
  }
end