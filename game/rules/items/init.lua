-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = {
  actions = {},
  selectors = {},
}

function Items.actions.add(item, position)
  local World = require "game.rules.world"
  item.position = position
  return World.actions.addEntity(item)
end

function Items.actions.remove(item)
  local World = require "game.rules.world"
  return World.actions.removeEntity(item)
end

function Items.actions.use(item, user)
  return function(dispatch)
    local Inventory = require "game.rules.inventory"
    item:useHandler(dispatch, user)
    if item.consumeOnUse then
      dispatch(Inventory.actions.removeItem(user, item))
    end
  end
end

function Items.selectors.getAll(state)
  local World = require "game.rules.world"
  return World.selectors.getAllWithComponents(state, "item")
end

function Items.selectors.getByPosition(state, position)
  local World = require "game.rules.world"
  return World.selectors.getByPosition(state, position, "item")
end

function Items.isUsable(item)
  return item.useHandler ~= nil
end

Items.Gear = require "game.rules.items.gear"
Items.Weapons = require "game.rules.items.weapons"

return Items