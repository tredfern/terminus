-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state, amount)
  assert(state.player.money, "Must have player with money to check funds")
  return state.player.money >= amount
end