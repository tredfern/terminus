-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Selectors = {}

function Selectors.get(state, perspective, position)
  if not state.fogOfWar then return nil end
  local view = state.fogOfWar[perspective]
  if not view then return nil end

  return view[position.hashKey]
end

return Selectors