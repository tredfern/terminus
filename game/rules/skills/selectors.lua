-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.getItemSkill(state, item)
  return state.skills[item.skill]
end

return Selectors