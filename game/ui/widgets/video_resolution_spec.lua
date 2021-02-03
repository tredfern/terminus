-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.video_resolution", function()
  local VideoResolution = require "game.ui.widgets.video_resolution"
  local MockLove = require "moonpie.test_helpers.mock_love"

  MockLove.mock(love.window, "getMode", function() return 640, 480 end)
  MockLove.mock(love.window, "getFullscreenModes", function()
    return {
      { width = 800, height = 600 },
      { width = 640, height = 480 },
      { width = 320, height = 240 },
    }
  end)

  it("defaults to displaying the current resolution", function()
    local subject = VideoResolution()
    local render = moonpie.test_render(subject)
    local displayText = render:findByID("displayText")
    assert.equals("640 x 480", displayText.text)
    assert.equals(640, subject:getResolution().width)
    assert.equals(480, subject:getResolution().height)
  end)

  it("can cycle through the resolution options", function()
    local subject = VideoResolution()
    local render = moonpie.test_render(subject)
    local button = render:findByID("btnNext")
    button:click()
    assert.equals(800, subject:getResolution().width)
    assert.equals(600, subject:getResolution().height)
    button:click()
    assert.equals(320, subject:getResolution().width)
    assert.equals(240, subject:getResolution().height)
    local prevButton = render:findByID("btnPrev")
    prevButton:click()
    assert.equals(800, subject:getResolution().width)
    assert.equals(600, subject:getResolution().height)
  end)

  it("has an option for full screen", function()
    local subject = VideoResolution()
    local render = moonpie.test_render(subject)
    local fullScreen = render:findByID("chkFullScreen")

    fullScreen:click()
    assert.is_true(subject:getFullScreen())
  end)

end)