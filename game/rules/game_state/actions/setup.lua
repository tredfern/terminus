-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Character = require "game.rules.character"
local Items = require "game.rules.items"
local map = require "game.rules.map"
local tables = require "moonpie.tables"
local MessageLog = require "game.rules.message_log"

return function()
  return function(dispatch, getState)
    dispatch(map.actions.set(
      map.generators.dungeon.generate(50, 50)
    ))
    local rooms = map.selectors.getRooms(getState())

    local playerStartRoom = tables.pickRandom(rooms)

    local player = Character.create {
        x = playerStartRoom.x + math.floor(playerStartRoom.width / 2),
        y = playerStartRoom.y + math.floor(playerStartRoom.height / 2),
        isPlayerControlled = true
      }
    dispatch(Character.actions.add(player))
    dispatch(Character.actions.equipItem(player, Items.list.sword:clone()))

    for _ = 1,2 do
      local r = tables.pickRandom(rooms)
      dispatch(map.actions.addEnemySpawner(
        r.x + love.math.random(r.width) - 1,
        r.y + love.math.random(r.height) - 1
      ))
    end


    -- Add some random items to some random rooms
    for _ = 1, 10 do
      local r = tables.pickRandom(rooms)
      dispatch(Items.actions.add(
        Items.list.healthPack, {
          x = r.x + love.math.random(r.width) - 1,
          y = r.y + love.math.random(r.height) - 1
        }
      ))
    end

    local r = tables.pickRandom(rooms)
    dispatch(Items.actions.add(
      Items.list.sprayBottle, {
        x = r.x + love.math.random(r.width) - 1,
        y = r.y + love.math.random(r.height) - 1
      }
    ))

    dispatch(MessageLog.actions.add(
      "Welcome to the jungle!"
    ))
  end
end