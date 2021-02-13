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
  return item.skill == nil or character.skills[item.skill] ~= nil
end

return Items