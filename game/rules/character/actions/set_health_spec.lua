-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.character.actions.set_health", function()
  local set_health = require "game.rules.character.actions.set_health"

  it("describes the new health level", function()
    local c = {}
    local action = set_health(c, 48)
    assert.equals("CHARACTER_SET_HEALTH", action.type)
    assert.equals(c, action.payload.character)
    assert.equals(48, action.payload.health)
  end)

end)