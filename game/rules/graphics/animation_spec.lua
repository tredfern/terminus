-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.animation", function()
  local Animation = require "game.rules.graphics.animation"

  it("can add frames to the animation", function()
    local image = {}
    local anim = Animation:new()
    anim:addFrame(image, 0.2)
    assert.equals(image, anim.frames[1].image)
    assert.equals(0.2, anim.frames[1].length)
  end)

  it("calculates the total length of the animation", function()
    local anim = Animation:new()
    anim:addFrame({}, 1)
    anim:addFrame({}, 1)
    anim:addFrame({}, 1)
    assert.equals(3, anim.length)
  end)

  it("can return the correct frame based on a current delta", function()
    local anim = Animation:new()
    anim:addFrame({}, 1)
    anim:addFrame({}, 1)
    anim:addFrame({}, 1)
    anim:addFrame({}, 1)

    local frame = anim:getFrame(14)
    assert.equals(anim.frames[2], frame)
  end)
end)