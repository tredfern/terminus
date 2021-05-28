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

  it("can deserialize data from a file", function()
    local binser = require "binser"
    local fileData = binser.serialize("hello, world")
    MockLove.mock(love.filesystem, "read", spy.new(function() return fileData end))
    assert.equals("hello, world", serializer.load("file/path"))
    assert.spy(love.filesystem.read).was.called_with("file/path")
  end)

  it("can serialize and deserialize a realistic looking store", function()
    local character = require "game.rules.character"

    local state = {
      characters = {
        character.create(),
        character.create(),
        character.create()
      },
      map = {
      }
    }

    local s = serializer.serialize(state)
    local out = serializer.deserialize(s)[1]
    assert.equals(3, #out.characters)
  end)
end)