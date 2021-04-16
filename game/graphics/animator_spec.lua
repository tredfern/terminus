-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.graphics.animator", function()
  local Animator = require "game.graphics.animator"
  local testSubject

  before_each(function()
    testSubject = Animator:new()
    testSubject:addAnimation("idle", {})
    testSubject:addAnimation("walk", {})
  end)

  it("can have animations added to the animator", function()
    local animator = Animator:new()
    local animation = {}

    animator:addAnimation("walk", animation)
    assert.equals(animation, animator.animations.walk)
  end)

  it("can set what animation should play", function()
    testSubject:play("idle")
    assert.equals(testSubject.animations.idle, testSubject.current)
    assert.equals(0, testSubject.playTime)
  end)

  it("updating keeps track of the time", function()
    testSubject:play("idle")
    testSubject:update(0.25)
    assert.equals(0.25, testSubject.playTime)
  end)

  it("can fetch the current frame", function()
    local frame = {}
    testSubject.animations.idle.getFrameImage = spy.new(function() return frame end)
    testSubject:play("idle")
    testSubject:update(0.2)
    testSubject:update(0.2)

    assert.equals(frame, testSubject:getCurrentFrame())
    assert.spy(testSubject.animations.idle.getFrameImage).was.called_with(testSubject.animations.idle, 0.4)
  end)
end)