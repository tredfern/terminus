-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.map.outline", function()
  local outline = require "game.rules.map.outline"

  it("knows the total size of the map", function()
    local o = outline:new(173, 182)
    assert.equals(173, o.width)
    assert.equals(182, o.height)
  end)

  it("can track rooms", function()
    local room = {}
    local o = outline:new()
    o:addRoom(room)
    assert.array_includes(room, o.rooms)
  end)

  it("can track corridors", function()
    local corridor = {}
    local o = outline:new()
    o:addCorridor(corridor)
    assert.array_includes(corridor, o.corridors)
  end)
end)