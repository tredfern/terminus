-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_attributes", function()
  local characterAttributes = require "game.ui.widgets.character_attributes"

  local attributes = require "game.rules.character.attributes"
  local sampleAttributes = {
    [attributes.strength] = 15,
    [attributes.agility] = 12,
    [attributes.endurance] = 18,
    [attributes.wit] = 21,
    [attributes.education] = 13,
    [attributes.social] = 19
  }

  it("display the character stats", function()
    local widget = moonpie.testRender(characterAttributes { attributes = sampleAttributes })

    assert.equals("15", widget:findByID("StrengthValue").text)
    assert.equals("12", widget:findByID("AgilityValue").text)
    assert.equals("18", widget:findByID("EnduranceValue").text)
    assert.equals("21", widget:findByID("WitValue").text)
    assert.equals("13", widget:findByID("EducationValue").text)
    assert.equals("19", widget:findByID("SocialValue").text)

    -- Adjustment buttons are not rendered in non-edit mode
    assert.is_nil(widget:findByID("StrengthIncrease"))
  end)

  it("provides plus/minus buttons if the attributes are editable", function()
    local widget = moonpie.testRender(characterAttributes { attributes = sampleAttributes, editable = true })
    assert.not_nil(widget:findByID("StrengthIncrease"))
    assert.not_nil(widget:findByID("StrengthDecrease"))
    assert.not_nil(widget:findByID("WitIncrease"))
    assert.not_nil(widget:findByID("WitDecrease"))
  end)
end)