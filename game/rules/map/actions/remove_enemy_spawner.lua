-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local types = require "game.rules.map.actions.types"

return function(spawner)
  return {
    type = types.remove_enemy_spawner,
    payload = {
      spawner = spawner
    }
  }
end