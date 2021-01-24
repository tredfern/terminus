-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = require "game.rules.character"
local map = require "game.rules.map"
local tables = require "moonpie.tables"

return function()
  return function(dispatch, get_state)
    dispatch(map.actions.set(
      map.create(50, 50)
    ))
    local rooms = map.selectors.get_rooms(get_state())

    local player_start_room = tables.pick_random(rooms)

    dispatch(character.actions.add(
      character.create {
        x = player_start_room.x + math.floor(player_start_room.width / 2),
        y = player_start_room.y + math.floor(player_start_room.height / 2),
        is_player_controlled = true
      }
    ))

    for _ = 1,8 do
      local r = tables.pick_random(rooms)
      dispatch(character.actions.add(
        character.create {
          is_enemy = true,
          x = r.x + math.floor(r.width / 2),
          y = r.y + math.floor(r.height / 2),
        }
      ))
    end
  end
end