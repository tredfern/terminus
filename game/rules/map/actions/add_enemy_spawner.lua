-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local types = require "game.rules.map.actions.types"

return function(x, y)
  return {
    payload = {
      x = x, y = y
    },
    type = types.ADD_ENEMY_SPAWNER

  }
end