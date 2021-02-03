-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.screens.options", function()
  local options = require "game.ui.screens.options"
  local MockLove = require "moonpie.test_helpers.mock_love"

  it("creates a component for the screen", function()
    assert.is_table(options())
  end)

  it("takes a parameter to point what screen to return to", function()
    local backScreen = spy.new(function() end)

    local screen = options({ returnScreen = backScreen })
    screen:findByID("btnClose"):click()
    assert.spy(backScreen).was.called()
  end)

  it("displays resolution options", function()
    local screen = options {}
    assert.not_nil(screen:findByID("videoResolution"))
  end)

  it("sets the new resolution if apply button is pushed", function()
    MockLove.mock(love.window, "getMode", function() return 640, 480 end)
    MockLove.mock(love.window, "setMode", spy.new(function() end))

    local screen = options {}
    local btnApply = screen:findByID("btnApply")
    btnApply:click()

    assert.spy(love.window.setMode).was.called_with(640, 480)
  end)

  it("tells moonpie to resize the window", function()
    MockLove.mock(love.window, "getMode", function() return 640, 480 end)
    spy.on(moonpie, "resize")

    local screen = options {}
    local btnApply = screen:findByID("btnApply")
    btnApply:click()

    assert.spy(moonpie.resize).was.called_with(640, 480)
  end)
end)