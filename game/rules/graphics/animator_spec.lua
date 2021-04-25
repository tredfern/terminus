-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.rules.graphics.animator", function()
  local Animator = require "game.rules.graphics.animator"
  local testSubject

  before_each(function()
    testSubject = Animator:new()
    testSubject:addAnimation("idle", {})
    testSubject:addAnimation("walk", {})
  end)

  it("defaults to not playing any animation", function()
    assert.is_false(testSubject.isPlaying)
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
    assert.is_true(testSubject.isPlaying)
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

  it("can play an animation once", function()
    local frame = {}
    testSubject.animations.walk.length = 0.4
    testSubject.animations.walk.getFrameImage = spy.new(function() return frame end)
    testSubject:playOnce("walk")
    testSubject:update(0.2)
    testSubject:update(0.2)
    testSubject:update(0.2)
    testSubject:getCurrentFrame()
    assert.spy(testSubject.animations.walk.getFrameImage)
      .was.called_with( testSubject.animations.walk, 0.39 )
    assert.is_false(testSubject.isPlaying)
  end)
end)