-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = require "game.rules.bestiary.types"

function Actions.add(entity, position)
  entity.position = position

  local World = require "game.rules.world"
  return World.actions.addEntity(entity)
end

return Actions