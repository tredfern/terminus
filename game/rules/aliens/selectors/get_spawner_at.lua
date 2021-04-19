-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local getSpawners = require "game.rules.aliens.selectors.get_spawners"
local Position = require "game.rules.world.position"

return function(state, x, y)
  local spawners = getSpawners(state)
  for _, v in ipairs(spawners) do
    if Position.equal(v.position, { x, y }) then
      return v
    end
  end
end