-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local sprite = require "game.rules.graphics.sprite"

local Items = {
  actions = {
    add = require "game.rules.items.actions.add",
    remove = require "game.rules.items.actions.remove",
    use = require "game.rules.items.actions.use"
  },
  selectors = {
    getAll = require "game.rules.items.selectors.get_all",
    getByPosition = require "game.rules.items.selectors.get_by_position"
  },
}
Items.list = {}

local function clone(item, props)
  props = props or {}
  tables.copyKeys(item, props, false)
  if item.image then
    props.sprite = sprite.fromImage(item.image)
  end

  return props
end

function Items.describe(props)
  props.clone = clone
  Items.list[props.key] = props
end

function Items.canUseItem(item, character)
  if not item.usable then return false end
  return item.skill == nil or character.skills[item.skill] ~= nil
end

function Items.isUsable(item)
  return item.useHandler ~= nil
end

return Items