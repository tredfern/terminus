-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_attributes", function()
  local characterAttributes = require "game.ui.widgets.character_attributes"

  it("display the character stats", function()
    local attributes = require "game.rules.character.attributes"
    local sampleAttributes = {
      [attributes.strength] = 15,
      [attributes.agility] = 12,
      [attributes.endurance] = 18,
      [attributes.wit] = 21,
      [attributes.education] = 13,
      [attributes.social] = 19
    }
    local widget = characterAttributes {
      attributes = sampleAttributes
    }


    assert.equals("15", widget:findByID("StrengthStat").text)
    assert.equals("12", widget:findByID("AgilityStat").text)
    assert.equals("18", widget:findByID("EnduranceStat").text)
    assert.equals("21", widget:findByID("WitStat").text)
    assert.equals("13", widget:findByID("EducationStat").text)
    assert.equals("19", widget:findByID("SocialStat").text)
  end)
end)