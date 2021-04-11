-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.graphics.sprite", function()
  local sprite = require "game.graphics.sprite"
  local testFile = "assets/graphics/alien_1.png"

  it("defaults to a solid white color", function()
    local test = sprite.fromImage({})
    assert.same({1, 1, 1, 1}, test.color)
  end)

  it("can accept an image data", function()
    local img = {}
    local test = sprite.fromImage(img)
    assert.not_nil(test)
    assert.equals(img, test:currentImage())
  end)

  it("can accept an image file", function()
    local imageMgr = require "moonpie.graphics.image"

    local test = sprite.fromFile(testFile)
    assert.equals(imageMgr.load(testFile), test.imageData)
  end)

  it("can draw the image", function()
    local mockLove = require "moonpie.test_helpers.mock_love"
    local test = sprite.fromFile(testFile)
    mockLove.mock(love.graphics, "setColor", spy.new(function() end))
    mockLove.mock(love.graphics, "draw", spy.new(function() end))

    test:draw(10, 20)
    assert.spy(love.graphics.setColor).was.called_with(test.color)
    assert.spy(love.graphics.draw).was.called_with(test.imageData, 10, 20)

  end)

  it("can have a color specified on construction", function()
    local img = {}
    local test = sprite.fromImage(img)
  end)

end)