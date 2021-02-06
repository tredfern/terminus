-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_abilities", function()
  local characterAbilities = require "game.ui.widgets.character_abilities"

  it("display the character stats", function()
    local character = {
      abilities = {
        strength = 15,
        agility = 12,
        endurance = 18,
        wit = 21,
        education = 13,
        social = 19
      }
    }
    local widget = characterAbilities {
      character = character
    }


    assert.equals("15", widget:findByID("strengthStat").text)
    assert.equals("12", widget:findByID("agilityStat").text)
    assert.equals("18", widget:findByID("enduranceStat").text)
    assert.equals("21", widget:findByID("witStat").text)
    assert.equals("13", widget:findByID("educationStat").text)
    assert.equals("19", widget:findByID("socialStat").text)
  end)
end)