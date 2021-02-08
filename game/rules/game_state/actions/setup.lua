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
    dispatch(Character.actions.equipItem(player, Items.list.sword))
    dispatch(Character.actions.addItemToInventory(player, Items.list.keycard))
    dispatch(Character.actions.addItemToInventory(player, Items.list.healthPack))
    dispatch(Character.actions.addItemToInventory(player, Items.list.laserGun))

    for _ = 1,8 do
      local r = tables.pickRandom(rooms)
      dispatch(Character.actions.add(
        Character.create {
          isEnemy = true,
          x = r.x + math.floor(r.width / 2),
          y = r.y + math.floor(r.height / 2),
        }
      ))
    end

    dispatch(MessageLog.actions.add(
      "Welcome to the jungle!"
    ))
  end
end