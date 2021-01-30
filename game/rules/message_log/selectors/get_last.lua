-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, count)
  if not state.message_log then return {} end

  local out = {}
  for i = #state.message_log, #state.message_log - count + 1, -1 do
    out[#out + 1] = state.message_log[i]
  end
  return out
end