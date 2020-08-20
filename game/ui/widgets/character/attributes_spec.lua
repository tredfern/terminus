-- Copyright (c) 2020 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.widgets.character.attributes", function()
  local character_attributes = require "game.ui.widgets.character.attributes"
  local mock_store = require "mock_store"
  local attribute = require "game.entities.character.attribute"
  local rendered

  before_each(function()
    mock_store({
      player = {
        attributes = {
          strength = attribute(10),
          dexterity = attribute(11),
          endurance = attribute(12),
          intelligence = attribute(13),
          knowledge = attribute(14),
          personality = attribute(15),
        }
      }
    })
    rendered = moonpie.test_render(character_attributes())
  end)

  it("renders a component", function()
    assert.not_nil(character_attributes())
  end)

  it("shows strength", function()
    assert.not_nil(rendered:find_by_id("strength_attribute"))
    assert.equals(10, rendered:find_by_id("strength_attribute"):value())
  end)

  it("shows dexterity", function()
    assert.equals(11, rendered:find_by_id("dexterity_attribute"):value())
  end)

  it("shows endurance", function()
    assert.equals(12, rendered:find_by_id("endurance_attribute"):value())
  end)

  it("shows intelligence", function()
    assert.equals(13, rendered:find_by_id("intelligence_attribute"):value())
  end)

  it("shows knowledge", function()
    assert.equals(14, rendered:find_by_id("knowledge_attribute"):value())
  end)

  it("shows personality", function()
    assert.equals(15, rendered:find_by_id("personality_attribute"):value())
  end)
end)