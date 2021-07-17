-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("game.ui.create_character.career_terms", function()
  local CareerTerms = require "game.ui.create_character.career_terms"

  it("renders a component", function()
    assert.is_table(CareerTerms { character = {} })
  end)
end)