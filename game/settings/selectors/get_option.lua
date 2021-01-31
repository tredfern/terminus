-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, option)
  local settings = state.settings or {}
  return settings[option]
end