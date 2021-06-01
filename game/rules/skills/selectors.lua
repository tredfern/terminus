-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local List = require "game.rules.skills.list"
local Selectors = {}

function Selectors.getCharacterSkills(_, entity)
  local out = {}
  for k, v in pairs(List) do
    out[k] = entity.attributes[v.attribute]
  end
  return out
end

function Selectors.getSkillValue(_, entity, skill)
  return entity.attributes[List[skill].attribute]
end

return Selectors