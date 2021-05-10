-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  if not state or not state.map or not state.map.outline then
    return { width = 0, height = 0, levels = 0 }
  end

  return {
    width = state.map.outline.width,
    height = state.map.outline.height,
    levels = state.map.outline.levels
  }
end