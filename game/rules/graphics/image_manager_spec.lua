-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.image_manager", function()
  local ImageManager = require "game.rules.graphics.image_manager"
  local mockLove = require "moonpie.test_helpers.mock_love"

  it("can store image data referenced by a key", function()
    local imageData = {}
    ImageManager.set("KEY1", imageData)
    assert.equals(imageData, ImageManager.get("KEY1"))
  end)

  it("can store quad information for the image", function()
    local imageData = {}
    local quad = {}
    ImageManager.set("KEY2", imageData, quad)
    local i, q = ImageManager.get("KEY2")
    assert.equals(i, imageData)
    assert.equals(q, quad)
  end)

  it("can return a wrapper that handles drawing the image and quad", function()
    mockLove.mock(love.graphics, "draw", spy.new(function() end))

    local imageData = {}
    local quad = {}
    ImageManager.set("KEY3", imageData, quad)

    local wrap = ImageManager.getDrawable("KEY3")
    wrap:draw(3, 4)
    assert.spy(love.graphics.draw).was.called_with(imageData, quad, 3, 4)
  end)

  it("can set the color of the wrapper", function()
    mockLove.mock(love.graphics, "setColor", spy.new(function() end))

    local imageData = {}
    local quad = {}
    ImageManager.set("KEY3", imageData, quad)

    local c = {}
    local wrap = ImageManager.getDrawable("KEY3")
    wrap:setColor(c)
    wrap:draw(3, 4)
    assert.spy(love.graphics.setColor).was.called_with(c)
  end)

  it("can load an image", function()
    ImageManager.load("LOADKEY", "assets/bestiary/alien_idle.png")
    assert.not_nil(ImageManager.get("LOADKEY"))
  end)

  it("can load an image with quad data", function()
    ImageManager.load("LOADKEY", "assets/bestiary/alien_idle.png", { 0, 0, 32, 32 })
    local i, q = ImageManager.get("LOADKEY")
    assert.not_nil(i)
    assert.not_nil(q)
  end)

  it("returns a drawable reference after loading", function()
    local d = ImageManager.load("LOADKEY", "assets/bestiary/alien_idle.png", { 0, 0, 32, 32 })
    assert.not_nil(d)
    assert.not_nil(d.draw)
  end)
end)