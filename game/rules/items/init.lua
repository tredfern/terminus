-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = {}
Items.list = {}

function Items.describe(props)
  Items.list[props.key] = {
    name = props.name,
    equipSlot = props.equipSlot,
    skills = props.skills
  }
end

function Items.canUseItem(item, character)
  if item.skills == nil or #item.skills == 0 then return true end

  for _, v in ipairs(item.skills) do
    if character.skills[v] then return true end
  end

  return false
end



return Items