-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local cargo_adjust = require "game.rules.actions.cargo_adjust"

return function(name, _)
  return function(dispatch)
    dispatch(cargo_adjust(name, 1))
  end
end