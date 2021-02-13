-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  if state.map == nil then return {} end
  return state.map.enemySpawners or {}
end