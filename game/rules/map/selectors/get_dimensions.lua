-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  if not state.map then
    return { width = 0, height = 0 }
  end

  return {
    width = state.map.outline.width,
    height = state.map.outline.height
  }
end