-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.selectors.get_rooms", function()
  local get_rooms = require "game.rules.map.selectors.get_rooms"


  it("returns the rooms from the active map", function()
    local rooms = {}
    local state = {
      map = {
        rooms = rooms
      }
    }

    assert.equals(rooms, get_rooms(state))
  end)
end)