-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.actions.location_update", function()
  local location_update = require "game.rules.actions.location_update"
  local types = require "game.rules.actions.types"

  it("as the location_update action type", function()
    local t = location_update()
    assert.equals(types.location_update, t.type)
  end)

  it("takes a payload identifying the location", function()
    local loc = {}
    local t = location_update(loc)
    assert.equals(loc, t.payload)
  end)
end)