-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Store = require "game.store"
local Keycard = require "game.rules.items.keycard"
local Position = require "game.rules.world.position"


return function(outline)
  for _=1,40 do
    local r = tables.pickRandom(outline.rooms)
    local p = Position.randomInRoom(r)

    Store.dispatch(Keycard.actions.add(p))
  end

end