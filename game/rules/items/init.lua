-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = {
  actions = {
    add = require "game.rules.items.actions.add"
  },
  selectors = {
    getAll = require "game.rules.items.selectors.get_all",
    getByPosition = require "game.rules.items.selectors.get_by_position"
  },
}
Items.list = {}

local function clone(item, props)
  props = props or {}

  return setmetatable(
    props,
    { __index = item }
  )
end

function Items.describe(props)
  props.clone = clone
  Items.list[props.key] = props
end

function Items.canUseItem(item, character)
  if not item.usable then return false end
  return item.skill == nil or character.skills[item.skill] ~= nil
end

function Items.use(item, character)
  local store = require "game.store"
  item:useHandler(character, store.dispatch)
end

return Items