-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.main_screen.quick_slots", function()
  local QuickSlots = require "game.ui.main_screen.quick_slots"


  it("displays any image for the hotkey", function()
    local img = {}
    local render = moonpie.testRender(QuickSlots {
      hotkeys = {
        { key = "1", value = { image = img }}
      }
    })

    local hotKeyButton = render:findByID("hotkey_1")
    assert.not_nil(hotKeyButton)
    local spriteImg = hotKeyButton:findByID("HotKeyImage")
    assert.equals(img, spriteImg.sprite)
  end)
end)