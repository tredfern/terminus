-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tables = require "moonpie.tables"
local Store = require "game.store"
local Items = require "game.rules.items"
local Position = require "game.rules.world.position"
local Selectors = require "game.rules.map.selectors"


return function()
  local rooms = Selectors.getRooms(Store.getState())

  for _=1,40 do
    local r = tables.pickRandom(rooms)
    local p = Position.randomInRoom(r)

    Store.dispatch(Items.actions.add(Items.Gear.keycard(), p))
  end

  for _ = 1, 240 do
    local r = tables.pickRandom(rooms)
    local p = Position.randomInRoom(r)
    Store.dispatch(Items.actions.add(Items.Gear.healthPack(), p))
  end

  local r = tables.pickRandom(rooms)
  local p = Position.randomInRoom(r)
  Store.dispatch(Items.actions.add(Items.Gear.sprayBottle(), p))
end