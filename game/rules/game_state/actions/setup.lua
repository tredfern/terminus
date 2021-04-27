-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Items = require "game.rules.items"
local map = require "game.rules.map"
local tables = require "moonpie.tables"
local MessageLog = require "game.rules.message_log"
local Player = require "game.rules.player"
local Aliens = require "game.rules.aliens"
local Position = require "game.rules.world.position"

return function()
  return function(dispatch, getState)
    dispatch(map.actions.create(50, 50, map.generators.dungeon))
    local rooms = map.selectors.getRooms(getState())

    local playerStartRoom = tables.pickRandom(rooms)

    local x = playerStartRoom.x + math.floor(playerStartRoom.width / 2)
    local y = playerStartRoom.y + math.floor(playerStartRoom.height / 2)
    dispatch(Player.actions.add(Position(x, y, playerStartRoom.level)))
    dispatch(Player.actions.equipItem(Items.list.sword:clone()))

    for _ = 1,20 do
      local r = tables.pickRandom(rooms)
      dispatch(Aliens.actions.addSpawner(
        Position(
          r.x + love.math.random(r.width) - 1,
          r.y + love.math.random(r.height) - 1,
          r.level
    )))
    end

    -- Add some random items to some random rooms
    for _ = 1, 40 do
      local r = tables.pickRandom(rooms)
      dispatch(Items.actions.add(
        Items.list.healthPack, {
          position = Position.new(
            r.x + love.math.random(r.width) - 1,
            r.y + love.math.random(r.height) - 1,
            r.level)
        }
      ))
    end

    local r = tables.pickRandom(rooms)
    dispatch(Items.actions.add(
      Items.list.sprayBottle, {
        position = Position.new(
          r.x + love.math.random(r.width) - 1,
          r.y + love.math.random(r.height) - 1,
          r.level)
      }
    ))

    dispatch(MessageLog.actions.add(
      MessageLog.messages.tutorial.welcome
    ))
  end
end