-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Actions = {}
Actions.types = {
  ENTITY_ADD = "ENTITY_ADD",
  ENTITY_REMOVE = "ENTITY_REMOVE",
  ENTITY_UPDATE = "WORLD_ENTITY_UPDATE"
}

function Actions.addEntity(entity)
  return {
    type = Actions.types.ENTITY_ADD,
    payload = {
      entity = entity
    }
  }
end

function Actions.removeEntity(entity)
  return {
    type = Actions.types.ENTITY_REMOVE,
    payload = {
      entity = entity
    }
  }
end

function Actions.updateEntity(entity, values)
  return {
    type = Actions.types.ENTITY_UPDATE,
    payload = {
      entity = entity,
      values = values
    }
  }
end

return Actions