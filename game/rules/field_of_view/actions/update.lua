-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actionTypes = require "game.rules.field_of_view.actions.types"

return function(entity, visibilityMap)
  return {
    type = actionTypes.UPDATE,
    payload = {
      entity = entity,
      visibilityMap = visibilityMap
    }
  }
end