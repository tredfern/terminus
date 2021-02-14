-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = {}
Items.list = {}

function Items.describe(props)
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