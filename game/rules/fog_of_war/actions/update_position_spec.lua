-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.fog_of_war.actions.update", function()
  local update = require "game.rules.fog_of_war.actions.update_position"

  it("takes a perspective, position, and tile information seen to track in FoW database", function()
    local entity, position, tile = {}, {}, {}
    local action = update(entity, position, tile)

    assert.equals("FOG_OF_WAR_UPDATE_POSITION", action.type)
    assert.equals(entity, action.payload.perspective)
    assert.equals(position, action.payload.position)
    assert.equals(tile, action.payload.tile)
  end)

  it("can take a hashKey for position", function()
    local entity, hash, tile = {}, 1234, {}
    local action = update(entity, hash, tile)
    assert.equals(hash, action.payload.positionHashKey)
  end)
end)