-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.world.actions.types"

return function(entity)
  return {
    type = actionTypes.ENTITY_REMOVE,
    payload = {
      entity = entity
    }
  }
end