-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.world.actions.types"

return function(entity, values)
  return {
    type = actionTypes.ENTITY_UPDATE,
    payload = {
      entity = entity,
      values = values
    }
  }
end