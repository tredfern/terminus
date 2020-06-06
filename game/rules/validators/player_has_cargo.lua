-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, name, quantity)
  quantity = quantity or 1
  if not state.player_cargo then
    return false
  end

  if not state.player_cargo[name] then
    return false
  end

  return state.player_cargo[name].quantity >= quantity
end