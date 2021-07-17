-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.stat_summary", function()
  local StatSummary = require "game.ui.create_character.stat_summary"

  it("displays the attributes and skills for the character", function()
    local character = {
      attributes = { },
      skills = { }
    }

    local s = StatSummary {
      character = character
    }

    assert.not_nil(s:findByID("character_attributes"))
    assert.not_nil(s:findByID("character_skills"))
  end)
end)