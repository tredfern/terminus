-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.player.reducer", function()
  local reducer = require "game.rules.player.reducer"
  local types = require "game.rules.player.types"

  it("updates when tracking player visited room", function()
    local room = {}
    local action = {
      type = types.TRACK_ROOM_VISIT,
      payload = { room = room }
    }

    local state = reducer({}, action)
    assert.not_nil(state.roomVisits[room])
  end)
end)