-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.serializer", function()
  local serializer = require "game.serializer"
  local MockLove = require "moonpie.test_helpers.mock_love"

  it("can write a table out to a file", function()
    MockLove.mock(love.filesystem, "write", spy.new(function() end))
    local dataToSave = {
      1,
      { a = 2 },
      3,
      foo = "bar"
    }

    serializer.save("file/path", dataToSave)
    assert.spy(love.filesystem.write).was.called()
  end)
end)