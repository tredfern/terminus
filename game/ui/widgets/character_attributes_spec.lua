-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character_attributes", function()
  local characterAttributes = require "game.ui.widgets.character_attributes"

  local attributes = require "game.rules.character.attributes"
  local sampleAttributes = {
    [attributes.strength] = 15,
    [attributes.dexterity] = 12,
    [attributes.endurance] = 18,
    [attributes.intelligence] = 21,
    [attributes.knowledge] = 13,
    [attributes.charisma] = 19
  }

  it("display the character stats", function()
    local widget = moonpie.testRender(characterAttributes { attributes = sampleAttributes })

    assert.equals("15", widget:findByID("STRENGTHValue").text)
    assert.equals("12", widget:findByID("DEXTERITYValue").text)
    assert.equals("18", widget:findByID("ENDURANCEValue").text)
    assert.equals("21", widget:findByID("INTELLIGENCEValue").text)
    assert.equals("13", widget:findByID("KNOWLEDGEValue").text)
    assert.equals("19", widget:findByID("CHARISMAValue").text)

    -- Adjustment buttons are not rendered in non-edit mode
    assert.is_nil(widget:findByID("StrengthIncrease"))
  end)

  it("provides plus/minus buttons if the attributes are editable", function()
    local widget = moonpie.testRender(characterAttributes { attributes = sampleAttributes, editable = true })
    assert.not_nil(widget:findByID("btnNextSTRENGTHValue"))
    assert.not_nil(widget:findByID("btnPrevSTRENGTHValue"))
    assert.not_nil(widget:findByID("btnNextINTELLIGENCEValue"))
    assert.not_nil(widget:findByID("btnPrevINTELLIGENCEValue"))
  end)
end)