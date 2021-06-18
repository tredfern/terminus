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

  describe("PLAYER_SET_HOT_KEY", function()
    it("stores the hotkey in state", function()
      local action = {
        type = types.SET_HOT_KEY,
        payload = {
          hotkey = "4",
          name = "Hot Key Name",
          image = {},
          handler = function() end
        }
      }
      local state = reducer({}, action)

      assert.not_nil(state.hotkeys["4"])
      assert.equals("Hot Key Name", state.hotkeys["4"].name)
      assert.equals(action.payload.image, state.hotkeys["4"].image)
      assert.equals(action.payload.handler, state.hotkeys["4"].handler)
    end)
  end)
end)