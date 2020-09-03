-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.events.start_game", function()
  local start = require "game.rules.events.game_start"
  local event_types = require "game.rules.events.types"

  it("has the game_start event type", function()
    local evt = start()
    assert.not_nil(event_types.game_start)
    assert.equals(event_types.game_start, evt.type)
  end)

  it("needs no payload because the event is clear enough", function()
    assert.is_nil(start().payload)
  end)
end)