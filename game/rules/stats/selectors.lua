-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.getValue(state, stat)
  if state.stats == nil or state.stats[stat] == nil then return 0 end

  return state.stats[stat].value
end

return Selectors