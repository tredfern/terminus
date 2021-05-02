-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Position = require "game.rules.world.position"

return function(state, view)
  if state.fieldOfView then
    local vm = state.fieldOfView[view]
    local out = {}

    for k, v in pairs(vm) do
      -- TODO: This is required because of the OOP model of VisibilityMap #115
      if type(k) == "number" and v then
        table.insert(out, Position.fromKey(k))
      end
    end
    return out
  end
end