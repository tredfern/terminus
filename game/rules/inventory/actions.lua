-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = {}
local types = require "game.rules.inventory.types"

function actions.addItem(entity, item)
  return {
    type = types.ADD_ITEM,
    payload = {
      entity = entity,
      item = item
    }
  }
end

function actions.equipItem(entity, item)
  return {
    type = types.EQUIP_ITEM,
    payload = {
      entity = entity,
      item = item
    }
  }
end

function actions.removeItem(entity, item)
  return {
    type = types.REMOVE_ITEM,
    payload = {
      entity = entity,
      item = item
    }
  }
end

return actions