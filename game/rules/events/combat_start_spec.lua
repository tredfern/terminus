-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.events.combat_start", function()
  local combat = require "game.rules.events.combat_start"
  local types = require "game.rules.events.types"

  it("has the event type of combat_start", function()
    local c = combat()
    assert.equals(types.combat_start, c.type)
    assert.not_nil(c.type)
  end)

  it("has information on what combat is starting", function()
    local c = combat({
      involved = "some value",
    })
    assert.equals("some value", c.payload.involved)
  end)

end)