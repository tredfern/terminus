-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local rules = {
  require "game.rules.new_game.create_spaceports",
  require "game.rules.new_game.starting_player_ship"
}

return function(state)
  for _, r in ipairs(rules) do
    r(state)
  end
end