-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.graphics.sprite", function()
  local sprite = require "game.graphics.sprite"

  it("can accept an image data", function()
    local img = {}
    local test = sprite.fromImage(img)
    assert.not_nil(test)
    assert.equals(img, test:currentImage())
  end)

  it("can accept an image file", function()
    local imageMgr = require "moonpie.graphics.image"

    local test = sprite.fromFile("assets/graphics/alien_1.png")
    assert.equals(imageMgr.load("assets/graphics/alien_1.png"), test.imageData)
  end)
end)