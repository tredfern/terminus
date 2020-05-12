-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return function(state)
  local spaceport = require "game.entities.spaceport"
  state.spaceports = {
    spaceport:new{ name = "Alpha Station" },
    spaceport:new{ name = "Beta Station" },
    spaceport:new{ name = "Charlie Station" },
    spaceport:new{ name = "Delta Station" },
    spaceport:new{ name = "Echo Station" },
  }
end